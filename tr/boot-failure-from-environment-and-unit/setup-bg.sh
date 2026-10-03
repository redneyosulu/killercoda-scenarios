#!/bin/bash
D=/tmp/dlab-m01-02
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
cat > "$D/myapp" <<'APP'
#!/bin/bash
# Fake service: validates APP_PORT, then serves the directory.
. "/tmp/dlab-m01-02/app.env"
case "$APP_PORT" in ''|*[!0-9]*) echo "FATAL: APP_PORT='$APP_PORT' is not a number" >&2; exit 1;; esac
echo "READY port=$APP_PORT" > "/tmp/dlab-m01-02/status"
exec python3 -m http.server "$APP_PORT" --directory "/tmp/dlab-m01-02" >/dev/null 2>&1
APP
chmod +x "$D/myapp"
echo "APP_PORT=eighty" > "$D/app.env"
cat > "$D/myapp.unit" <<'UNIT'
[Service]
ExecStart=/tmp/dlab-m01-02/myapp-old
UNIT
cat > "$D/boot.sh" <<'BOOT'
#!/bin/bash
D=/tmp/dlab-m01-02
{
echo "== boot $(date -u +%H:%M:%S) =="
BIN=$(grep -oP '^ExecStart=\K.*' "$D/myapp.unit")
if [ ! -x "$BIN" ]; then echo "myapp.service: Failed with result 'exit-code', status=203/EXEC: $BIN missing"; exit 3; fi
. "$D/app.env"
case "$APP_PORT" in ''|*[!0-9]*) echo "myapp[1]: FATAL: APP_PORT='$APP_PORT' is not a number"; exit 1;; esac
pkill -f "http.server $APP_PORT" 2>/dev/null
"$BIN" >/dev/null 2>&1 &
 sleep 1
if curl -fs -m 3 "http://127.0.0.1:$APP_PORT/" >/dev/null; then echo "myapp.service: active, answered on $APP_PORT"; else echo "myapp.service: start request repeated too quickly"; exit 1; fi
} 2>&1 | tee -a "$D/boot.log"
BOOT
chmod +x "$D/boot.sh"
: > "$D/boot.log"
touch "$D/.ready" && chmod 600 "$D/.ready"
