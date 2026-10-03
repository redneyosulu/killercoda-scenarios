#!/bin/bash
D=/tmp/dlab-m06-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/cache" "$D/feature" "$D/main"
cat > "$D/api.py" <<'PY'
import http.server, json
SCOPES = {"fixture-full-0000": {"status", "deploy"},
          "fixture-status-0001": {"status"}}
NEED = {"/status": "status", "/deploy": "deploy"}
class H(http.server.BaseHTTPRequestHandler):
    def _send(self, code, body):
        raw = body if isinstance(body, bytes) else body.encode()
        self.send_response(code)
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        try:
            self.wfile.write(raw)
        except BrokenPipeError:
            pass
    def _scope(self):
        auth = self.headers.get("Authorization", "")
        tok = auth[7:] if auth.startswith("Bearer ") else ""
        return SCOPES.get(tok, set())
    def do_GET(self):
        if self.path == "/status" and "status" in self._scope():
            self._send(200, json.dumps({"status": "ok"}) + "\n")
        elif self.path == "/status":
            self._send(403, json.dumps({"error": "forbidden: status scope required"}) + "\n")
        else:
            self._send(404, json.dumps({"error": "no such path"}) + "\n")
    def do_POST(self):
        if self.path == "/deploy" and "deploy" in self._scope():
            self._send(200, json.dumps({"deployed": "staging"}) + "\n")
        elif self.path == "/deploy":
            self._send(403, json.dumps({"error": "forbidden: deploy scope required"}) + "\n")
        else:
            self._send(404, json.dumps({"error": "no such path"}) + "\n")
    def log_message(self, *a):
        pass
http.server.ThreadingHTTPServer(("127.0.0.1", 18089), H).serve_forever()
PY
pkill -f "dlab-m06-03/api.py" 2>/dev/null || true
nohup python3 "$D/api.py" >"$D/api.log" 2>&1 &
echo $! > "$D/api.pid"
sleep 1
printf 'requests==2.32.3\n' > "$D/deps.lock"
echo "FROM=main" > "$D/cache/deps-main.marker"

touch "$D/.ready" && chmod 600 "$D/.ready"
