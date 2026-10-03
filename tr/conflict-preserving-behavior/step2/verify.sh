#!/bin/bash
# dlab-m04-01 step 2
D=/tmp/dlab-m04-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

cd "$D/repo" || fail "repo missing"
[ -f check.sh ] || fail "write check.sh before resolving"
bash check.sh >/dev/null 2>&1 || fail "check.sh must pass on the resolved file"
! grep -q '<<<<<<<' app.conf || fail "no markers may remain"
grep -q '30' app.conf || fail "resolved file must keep the 30 side"
grep -q '10' app.conf || fail "resolved file must keep the 10 side"

echo "Step 2 OK."
