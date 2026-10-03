#!/bin/bash
D=/tmp/dlab-m02-02
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
cat > "$D/upstream.py" <<'PY'
import http.server, os, sys, time
mode = os.environ.get("UPSTREAM_MODE", "healthy")
port = int(sys.argv[1]) if len(sys.argv) > 1 else 18081
log = open(os.environ.get("UPSTREAM_LOG", "/tmp/up.log"), "a", buffering=1)
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        ts = time.strftime("%H:%M:%S", time.gmtime())
        if mode == "fail503":
            log.write("%s upstream %s -> 503\n" % (ts, self.path)); self.send_response(503); self.end_headers(); self.wfile.write(b"overload")
        elif mode == "hang":
            log.write("%s upstream %s -> hang\n" % (ts, self.path)); time.sleep(10); self.send_response(200); self.end_headers()
        else:
            log.write("%s upstream %s -> 200\n" % (ts, self.path)); self.send_response(200); self.end_headers(); self.wfile.write(b"ok")
    def log_message(self, *a): pass
http.server.HTTPServer(("127.0.0.1", port), H).serve_forever()
PY
cat > "$D/proxy.py" <<'PY'
import http.server, time, urllib.request, urllib.error
LOG = "/tmp/dlab-m02-02/proxy.log"
UP = "http://127.0.0.1:18081"
class H(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        ts = time.strftime("%H:%M:%S", time.gmtime())
        t0 = time.time()
        try:
            r = urllib.request.urlopen(UP + self.path, timeout=2)
            body, code = r.read(), r.status
        except urllib.error.HTTPError as e:
            body, code = e.read(), e.code
        except Exception:
            body, code = b"bad gateway", 502
        dt = time.time() - t0
        with open(LOG, "a") as f: f.write("%s proxy %s -> %s in %.2fs\n" % (ts, self.path, code, dt))
        self.send_response(code); self.end_headers(); self.wfile.write(body)
    def log_message(self, *a): pass
http.server.HTTPServer(("127.0.0.1", 18080), H).serve_forever()
PY
sed -i "s#/tmp/dlab-m02-02/proxy.log#$D/proxy.log#" "$D/proxy.py"
sed -i "s#http://127.0.0.1:18081#http://127.0.0.1:18081#" "$D/proxy.py"
export UPSTREAM_LOG="$D/upstream.log"
: > "$D/proxy.log"; : > "$D/upstream.log"
pkill -f "upstream.py 18081" 2>/dev/null; pkill -f "proxy.py" 2>/dev/null; sleep 1
UPSTREAM_LOG="$D/upstream.log" nohup python3 "$D/upstream.py" 18081 >"$D/up.log" 2>&1 &
echo $! > "$D/upstream.pid"
nohup python3 "$D/proxy.py" >"$D/proxy.out" 2>&1 &
echo $! > "$D/proxy.pid"
sha256sum "$D/proxy.py" | awk '{print $1}' > "$D/proxy.sha"
sleep 1
touch "$D/.ready" && chmod 600 "$D/.ready"
