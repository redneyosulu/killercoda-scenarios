#!/bin/bash
# dlab-m01-03 step 1
D=/tmp/dlab-m01-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

n=$(ls "$D" | grep -c '^f-')
[ "$n" -eq 50000 ] || fail "expected 50000 pressure files, found $n"
grep -q "before" "$D/numbers.txt" || fail "numbers.txt must record the baseline"
echo "Step 1 OK."
