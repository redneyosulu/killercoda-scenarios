#!/bin/bash
D=/tmp/dlab-m03-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
cat > "$D/api.py" <<'PY'
import http.server, json, os, time, socketserver
D = "/tmp/dlab-m03-03"
HITS = os.path.join(D, "hits.log")
STATE = {"limited": 0}
class H(http.server.BaseHTTPRequestHandler):
    def _send(self, code, body, extra=None):
        raw = body if isinstance(body, bytes) else body.encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        for k, v in (extra or {}).items(): self.send_header(k, v)
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        try: self.wfile.write(raw)
        except BrokenPipeError: pass
    def do_GET(self):
        if self.path == "/ok":
            self._send(200, json.dumps({"status": "ok"}))
        elif self.path == "/slow":
            time.sleep(30); self._send(200, json.dumps({"status": "slow-ok"}))
        elif self.path == "/limited":
            STATE["limited"] += 1
            open(HITS, "a").write("hit %d\n" % STATE["limited"])
            if STATE["limited"] <= 2:
                self._send(429, json.dumps({"error": "slow down"}), {"Retry-After": "1"})
            else:
                self._send(200, json.dumps({"status": "ok-after-retry"}))
        elif self.path == "/broken":
            self._send(200, '{"status": "tru')
        elif self.path == "/reset":
            STATE["limited"] = 0
            open(HITS, "w").write("")
            self._send(200, json.dumps({"status": "reset"}))
        else:
            self._send(404, json.dumps({"error": "no such path"}))
    def log_message(self, *a): pass
socketserver.ThreadingTCPServer.allow_reuse_address = True
socketserver.ThreadingTCPServer(("127.0.0.1", 18084), H).serve_forever()
PY
pkill -f "api.py" 2>/dev/null || true
: > "$D/hits.log"
nohup python3 "$D/api.py" >"$D/api.log" 2>&1 &
echo $! > "$D/api.pid"
sleep 1

touch "$D/.ready" && chmod 600 "$D/.ready"
