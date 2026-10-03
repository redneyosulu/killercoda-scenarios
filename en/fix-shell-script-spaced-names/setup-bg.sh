#!/bin/bash
D=/tmp/dlab-m03-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/files" "$D/out-broken"
printf 'data\n' > "$D/files/Q3 report (final).txt"
printf 'data\n' > "$D/files/-leading-dash.log"
printf 'data\n' > "$D/files/normal.txt"
cat > "$D/broken.sh" <<'BSH'
#!/bin/bash
# BROKEN on purpose: parses ls, unquoted, no guards
cd /tmp/dlab-m03-01/files
mkdir -p /tmp/dlab-m03-01/out-broken
count=0
for f in $(ls); do
  cp $f /tmp/dlab-m03-01/out-broken/$f 2>/dev/null
  count=$((count+1))
done
echo "copied $count files"
BSH
chmod +x "$D/broken.sh"
touch "$D/.ready" && chmod 600 "$D/.ready"
