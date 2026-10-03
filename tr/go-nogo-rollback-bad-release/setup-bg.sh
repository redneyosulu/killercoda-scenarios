#!/bin/bash
D=/tmp/dlab-m08-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/releases/v1" "$D/releases/v2"
cat > "$D/releases/v1/server.py" <<'PY'
import http.server
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        body = b"v1-ok\n" if self.path != "/version" else b"v1\n"
        self.send_response(200)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        try: self.wfile.write(body)
        except BrokenPipeError: pass
    def log_message(self, *a): pass
http.server.ThreadingHTTPServer(("127.0.0.1", 18090), H).serve_forever()
PY
cat > "$D/releases/v2/server.py" <<'PY'
import http.server
N = [0]
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        N[0] += 1
        if self.path == "/version":
            body, code = b"v2\n", 200
        elif N[0] % 3 == 0:
            body, code = b"boom\n", 500
        else:
            body, code = b"v2-ok\n", 200
        self.send_response(code)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        try: self.wfile.write(body)
        except BrokenPipeError: pass
    def log_message(self, *a): pass
http.server.ThreadingHTTPServer(("127.0.0.1", 18090), H).serve_forever()
PY
cat > "$D/rollout.sh" <<'EOF'
#!/bin/bash
D=/tmp/dlab-m08-03
ver=${1:?usage: rollout.sh v1|v2}
pkill -f "dlab-m08-03/current/server.py" 2>/dev/null || true
sleep 1
ln -sfn "$D/releases/$ver" "$D/current"
nohup python3 "$D/current/server.py" >"$D/$ver.log" 2>&1 &
sleep 1
echo "$ver digest: $(sha256sum "$D/current/server.py" | cut -d' ' -f1 | cut -c1-16)"
EOF
chmod +x "$D/rollout.sh"
cat > "$D/sample.sh" <<'EOF'
#!/bin/bash
n=${1:-60}
err=0
for i in $(seq 1 "$n"); do
  code=$(curl -s -o /dev/null -w '%{http_code}' --max-time 3 http://127.0.0.1:18090/ || echo 000)
  [ "$code" = "200" ] || err=$((err+1))
done
echo "requests=$n errors=$err rate=$((err*100/n))%"
EOF
chmod +x "$D/sample.sh"
"$D/rollout.sh" v1

touch "$D/.ready" && chmod 600 "$D/.ready"
