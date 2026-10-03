#!/bin/bash
D=/tmp/dlab-m06-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
git config --global user.email "learner@example.invalid" 2>/dev/null || true
git config --global user.name "Learner" 2>/dev/null || true
git config --global init.defaultBranch main 2>/dev/null || true
mkdir -p "$D/repo"
cd "$D/repo"
git init -qb main 2>/dev/null || git init -q
cat > app.sh <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
greet() { echo "hello $1"; }
EOF
cat > test_app.sh <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
. ./app.sh
[ "$(greet world)" = "hello world" ] || { echo "FAIL: greet world"; exit 1; }
[ "$(greet mars)" = "hello mars" ] || { echo "FAIL: greet mars"; exit 1; }
echo TESTS-PASS
EOF
cat > build.sh <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
rm -rf dist && mkdir -p dist
cp app.sh dist/
echo "built $(ls dist)"
EOF
cat > package.sh <<'EOF'
#!/bin/bash
cd "$(dirname "$0")" || exit 1
sha=$(git rev-parse --short HEAD)
digest=$(sha256sum dist/app.sh | cut -d' ' -f1 | cut -c1-12)
tar -czf "dist/app-$sha-$digest.tar.gz" -C dist app.sh
echo "artifact dist/app-$sha-$digest.tar.gz"
EOF
chmod +x app.sh test_app.sh build.sh package.sh
git add -A && git commit -qm "pipeline repo: greet service with tests" || true

touch "$D/.ready" && chmod 600 "$D/.ready"
