#!/bin/bash
D=/tmp/dlab-m05-02
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/app"
cat > "$D/app/app.py" <<'PY'
import http.server, os, time, urllib.parse
import psycopg2
DSN = os.environ.get("DATABASE_URL", "postgresql://app:fixture-pw-0000@db:5432/appdb")
def db():
    for i in range(30):
        try:
            c = psycopg2.connect(DSN, connect_timeout=3)
            c.autocommit = True
            return c
        except Exception as e:
            print("db not ready (%s), retry %d" % (e, i), flush=True)
            time.sleep(2)
    print("FATAL: " + str(e), flush=True)
    raise SystemExit(1)
boot = db()
boot.cursor().execute("CREATE TABLE IF NOT EXISTS kv(k TEXT PRIMARY KEY, v TEXT)")
boot.close()
print("app ready", flush=True)
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
    def do_GET(self):
        u = urllib.parse.urlparse(self.path)
        q = urllib.parse.parse_qs(u.query)
        try:
            c = psycopg2.connect(DSN, connect_timeout=3)
            c.autocommit = True
            cur = c.cursor()
            if u.path == "/put":
                cur.execute("INSERT INTO kv(k,v) VALUES(%s,%s) ON CONFLICT(k) DO UPDATE SET v=EXCLUDED.v",
                            (q.get("k", [""])[0], q.get("v", [""])[0]))
                self._send(200, "stored\n")
            elif u.path == "/get":
                cur.execute("SELECT v FROM kv WHERE k=%s", (q.get("k", [""])[0],))
                row = cur.fetchone()
                if row:
                    self._send(200, '{"k":"%s","v":"%s"}\n' % (q.get("k", [""])[0], row[0]))
                else:
                    self._send(404, "missing\n")
            else:
                self._send(200, "ok\n")
            c.close()
        except Exception as e:
            self._send(500, "db error: %s\n" % e)
    def log_message(self, *a):
        pass
http.server.ThreadingHTTPServer(("0.0.0.0", 18086), H).serve_forever()
PY
cat > "$D/app/Dockerfile" <<'EOF'
FROM python:3.12-slim-bookworm
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py ./
EXPOSE 18086
CMD ["python3", "app.py"]
EOF
printf 'psycopg2-binary==2.9.10\n' > "$D/app/requirements.txt"
docker pull -q postgres:16-alpine >/dev/null 2>&1 || true
docker pull -q python:3.12-slim-bookworm >/dev/null 2>&1 || true
if ! docker compose version >/dev/null 2>&1; then
  mkdir -p /usr/local/lib/docker/cli-plugins
  curl -sSL -o /usr/local/lib/docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.29.7/docker-compose-linux-x86_64
  chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
fi
docker compose version

touch "$D/.ready" && chmod 600 "$D/.ready"
