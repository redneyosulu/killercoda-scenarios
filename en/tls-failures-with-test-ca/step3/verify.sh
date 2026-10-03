#!/bin/bash
# dlab-m02-03 step 3
D=/tmp/dlab-m02-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "reissue" "$D/repairs.txt" || fail "name reissue as the date/SAN repair"
grep -qi "chain" "$D/repairs.txt" || fail "name serving the full chain"
[ -f "$D/TEST-ONLY.txt" ] || fail "CA dir must stay labeled TEST ONLY"
echo "Step 3 OK."
