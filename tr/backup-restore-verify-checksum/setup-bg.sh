#!/bin/bash
D=/tmp/dlab-m07-02
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
mkdir -p "$D/src" "$D/restore"
cat > "$D/src/schema.json" <<'EOF'
{"schema": 1, "app": "fixture-reader 0.3.0"}
EOF
printf 'alpha\nbravo\ncharlie\ndelta\n' > "$D/src/records.txt"
cat > "$D/src/app.py" <<'PY'
import json, sys
d = sys.argv[sys.argv.index("--dir") + 1] if "--dir" in sys.argv else "."
recs = open(d + "/records.txt").read().split()
meta = json.load(open(d + "/schema.json"))
print("schema=%s app=%s records=%d" % (meta["schema"], meta["app"], len(recs)))
PY
cat > "$D/src/migrate.sh" <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
echo "migrated schema $(python3 -c "import json; print(json.load(open('schema.json'))['schema'])") at $(date -u +%FT%TZ)" > migrated.marker
EOF
chmod +x "$D/src/migrate.sh"
git config --global user.email "learner@example.invalid" 2>/dev/null || true
git config --global user.name "Learner" 2>/dev/null || true

touch "$D/.ready" && chmod 600 "$D/.ready"
