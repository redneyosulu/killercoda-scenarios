#!/bin/bash
# dlab-m04-01 step 3
D=/tmp/dlab-m04-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

cd "$D/repo" || fail "repo missing"
msg=$(git log -1 --format=%B)
echo "$msg" | grep -q '30' || fail "message must name the 30 side"
echo "$msg" | grep -q '10' || fail "message must name the 10 side"
[ "$(git rev-list --parents -n 1 HEAD | wc -w)" = "3" ] || fail "HEAD must be a merge commit (two parents)"
! grep -rq '<<<<<<<' --include='*.conf' . || fail "no markers may remain"
bash check.sh >/dev/null 2>&1 || fail "check.sh must still pass"

echo "Step 3 OK."
