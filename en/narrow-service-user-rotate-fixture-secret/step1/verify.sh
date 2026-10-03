#!/bin/bash
# dlab-m08-01 step 1
D=/tmp/dlab-m08-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "job" "$D/reach-map.txt" || fail "map must state the real job"
grep -q "secret/old.key" "$D/reach-map.txt" || fail "map must name the credential grant to remove"
grep -qiE "theft|steal|çal|sız" "$D/reach-map.txt" || fail "each grant needs its theft scenario"
grep -qiE "other" "$D/reach-map.txt" || fail "map must name the second excess grant"

echo "Step 1 OK."
