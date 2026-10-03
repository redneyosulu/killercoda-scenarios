#!/bin/bash
# dlab-m01-02 step 2
D=/tmp/dlab-m01-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "203" "$D/boot.log" || fail "boot.log must show the 203/EXEC line first"
grep -qi "203" "$D/first.txt" || fail "first.txt must name the 203 fault as firing first"
echo "Step 2 OK."
