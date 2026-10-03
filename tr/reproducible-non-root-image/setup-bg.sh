#!/bin/bash
D=/tmp/dlab-m05-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/ctx"
cat > "$D/ctx/server.py" <<'PY'
import http.server, os
DATA = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data")
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            body = b"ok\n"
        elif self.path == "/write":
            os.makedirs(DATA, exist_ok=True)
            p = os.path.join(DATA, "hits.log")
            n = 0
            if os.path.exists(p):
                with open(p) as f:
                    n = sum(1 for _ in f)
            with open(p, "a") as f:
                f.write("hit %d\n" % (n + 1))
            body = ("wrote %d\n" % (n + 1)).encode()
        else:
            self.send_response(404)
            self.end_headers()
            return
        self.send_response(200)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        try:
            self.wfile.write(body)
        except BrokenPipeError:
            pass
    def log_message(self, *a):
        pass
http.server.ThreadingHTTPServer(("0.0.0.0", 18085), H).serve_forever()
PY
cat > "$D/ctx/smoke.py" <<'PY'
import sys
import requests
base = "http://127.0.0.1:18085"
r = requests.get(base + "/", timeout=5)
r.raise_for_status()
r = requests.get(base + "/write", timeout=5)
r.raise_for_status()
print("SMOKE-OK:", r.text.strip())
PY
printf 'requests==2.32.3\n' > "$D/ctx/requirements.txt"
docker pull -q python:3 >/dev/null 2>&1 || true
docker pull -q python:3.12-slim-bookworm >/dev/null 2>&1 || true

touch "$D/.ready" && chmod 600 "$D/.ready"
