#!/bin/bash
D=/tmp/dlab-m05-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/app"
cat > "$D/app/server.py" <<'PY'
import http.server, os, signal, threading, time
START = time.time()
WARM_AFTER = int(os.environ.get("WARM_AFTER", "15"))
dep_ready = threading.Event()
HOLD = None
inflight = 0
lock = threading.Lock()
def warmer():
    time.sleep(WARM_AFTER)
    dep_ready.set()
threading.Thread(target=warmer, daemon=True).start()
class H(http.server.BaseHTTPRequestHandler):
    def _send(self, code, body):
        raw = body if isinstance(body, bytes) else body.encode()
        self.send_response(code)
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers()
        try:
            self.wfile.write(raw)
        except (BrokenPipeError, ConnectionResetError):
            pass
    def do_GET(self):
        global inflight, HOLD
        u = self.path
        if u == "/ready":
            if dep_ready.is_set():
                self._send(200, "ready\n")
            else:
                self._send(503, "warming\n")
        elif u == "/slow":
            with lock:
                inflight += 1
            try:
                time.sleep(10)
                self._send(200, "slow-ok\n")
            finally:
                with lock:
                    inflight -= 1
        elif u.startswith("/alloc"):
            import urllib.parse
            q = urllib.parse.parse_qs(urllib.parse.urlparse(u).query)
            mb = int(q.get("mb", ["50"])[0])
            HOLD = bytearray(mb * 1024 * 1024)
            for i in range(0, len(HOLD), 4096):
                HOLD[i] = 1
            self._send(200, "held %d MB\n" % mb)
        elif u == "/":
            self._send(200, "ok\n")
        else:
            self._send(404, "nope\n")
    def log_message(self, *a):
        pass
httpd = http.server.ThreadingHTTPServer(("0.0.0.0", 18088), H)
def on_term(signum, frame):
    def waiter():
        waited = 0
        while waited < 25:
            with lock:
                n = inflight
            if n == 0:
                break
            time.sleep(0.5)
            waited += 0.5
        httpd.shutdown()
    threading.Thread(target=waiter, daemon=True).start()
signal.signal(signal.SIGTERM, on_term)
httpd.serve_forever()
PY
docker pull -q python:3.12-slim-bookworm >/dev/null 2>&1 || true

touch "$D/.ready" && chmod 600 "$D/.ready"
