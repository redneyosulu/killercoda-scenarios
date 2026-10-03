#!/bin/bash
D=/tmp/dlab-m01-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
id svc >/dev/null 2>&1 || useradd -M -s /bin/false svc
groupadd -f appread
usermod -aG appread svc 2>/dev/null || true
echo "db_password=SECRET-STUB" > "$D/app.conf"
echo "listen=127.0.0.1:18080" >> "$D/app.conf"
chown root:root "$D/app.conf"
chmod 600 "$D/app.conf"
chmod 755 "$D"
touch "$D/.ready" && chmod 600 "$D/.ready"
