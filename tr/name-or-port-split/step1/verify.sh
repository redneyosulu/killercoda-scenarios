#!/bin/bash
# dlab-m02-01 step 1
D=/tmp/dlab-m02-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "127.0.0.2" "$D/faults.txt" || fail "faults.txt must name the wrong address 127.0.0.2"
grep -q "19090" "$D/faults.txt" || fail "faults.txt must name the wrong port 19090"
echo "Step 1 OK."
