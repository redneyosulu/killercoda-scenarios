#!/bin/bash
D=/tmp/dlab-m08-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
useradd -m -s /bin/bash svc 2>/dev/null || true
mkdir -p "$D/job" "$D/secret" "$D/other"
cat > "$D/job/job.sh" <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
[ -r secret.key ] || { echo "no narrow secret channel"; exit 1; }
echo "job-ok $(date -u +%FT%TZ)" > result.txt
EOF
chmod +x "$D/job/job.sh"
cat > "$D/job/secret.key" <<'EOF'
# FICTIONAL fixture secret, narrow channel
SECRET=fixture-old-0000
EOF
cat > "$D/secret/old.key" <<'EOF'
# FICTIONAL fixture secret, wide channel (to be purged)
SECRET=fixture-old-0000
EOF
echo "scratch" > "$D/other/note.txt"
chmod -R a+rX "$D/job" "$D/secret" "$D/other"

touch "$D/.ready" && chmod 600 "$D/.ready"
