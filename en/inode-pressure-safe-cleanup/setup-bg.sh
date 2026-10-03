#!/bin/bash
D=/tmp/dlab-m01-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
df -i /tmp | awk 'NR==2{print $3, $4}' > "$D/baseline.txt"
ls /tmp > "$D/tmp-before.txt"
i=0
while [ $i -lt 50000 ]; do
  : > "$D/f-$i"
  i=$((i+1))
done
echo "TOTAL_BUDGET=100000" > "$D/budget.txt"
touch "$D/.ready" && chmod 600 "$D/.ready"
