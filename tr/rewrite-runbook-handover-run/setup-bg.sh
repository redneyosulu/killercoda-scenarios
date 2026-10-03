#!/bin/bash
D=/tmp/dlab-m07-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
git config --global user.email "learner@example.invalid" 2>/dev/null || true
git config --global user.name "Learner" 2>/dev/null || true
mkdir -p "$D/data"
truncate -s 50M "$D/data/junk.cache"
head -c 2000000 /dev/urandom > "$D/data/app.log" 2>/dev/null || head -c 2000000 /dev/zero > "$D/data/app.log"
cat > "$D/BROKEN-RUNBOOK.md" <<'EOF'
# Disk full-ish runbook (BROKEN, do not trust)
If disk looks full, delete something and restart the thing.
Commands: clean up, restart.
Done when it feels fine.
EOF
cat > "$D/verify-incident.sh" <<'EOF'
#!/bin/bash
D=/tmp/dlab-m07-03
ok=true
[ -e "$D/data/junk.cache" ] && { echo "PRESENT junk.cache"; ok=false; } || echo "GONE junk.cache"
sz=$(stat -c %s "$D/data/app.log")
echo "app.log bytes: $sz"
[ "$sz" -lt 1000000 ] || { echo "TOO-BIG app.log"; ok=false; }
[ "$ok" = true ] && echo "DONE-CONDITION-PASS" || echo "DONE-CONDITION-FAIL"
EOF
chmod +x "$D/verify-incident.sh"
cd "$D" && git init -qb main 2>/dev/null || git init -q
git add -A && git commit -qm "broken runbook plus fixture" || true

touch "$D/.ready" && chmod 600 "$D/.ready"
