#!/bin/bash
# dlab-m04-01 step 1
D=/tmp/dlab-m04-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

cd "$D/repo" || fail "repo missing: init it under $D/repo first"
grep -q '<<<<<<<' app.conf || fail "app.conf must show conflict markers"
git log --all --oneline | grep -q "TIMEOUT=30" || fail "main side commit (TIMEOUT=30) missing"
git log --all --oneline | grep -q "TIMEOUT=10" || fail "branch side commit (TIMEOUT=10) missing"

echo "Step 1 OK."
