#!/bin/bash
# dlab-m02-01 step 2
D=/tmp/dlab-m02-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "name" "$D/split.txt" || fail "split.txt must name the NAME layer as guilty (English)"
grep -q "200" "$D/direct.txt" || fail "direct.txt must hold the direct-port 200 proof"
echo "Step 2 OK."
