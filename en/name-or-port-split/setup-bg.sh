#!/bin/bash
D=/tmp/dlab-m02-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/www"
echo "lab-ok" > "$D/www/index.html"
grep -q "svc-lab.test" /etc/hosts || echo "127.0.0.2 svc-lab.test" >> /etc/hosts
pkill -f "http.server 18080" 2>/dev/null || true
nohup python3 -m http.server 18080 --directory "$D/www" >"$D/app.log" 2>&1 &
echo $! > "$D/app.pid"
sleep 1
touch "$D/.ready" && chmod 600 "$D/.ready"
