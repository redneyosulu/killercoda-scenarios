#!/bin/bash
# dlab-m07-01 step 1
D=/tmp/dlab-m07-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "checkout" "$D/scope.txt" || fail "scope.txt must name the spiking endpoint"
grep -q "10" "$D/scope.txt" || fail "scope.txt must name the first spike minute"
grep -q "25" "$D/scope.txt" || fail "scope.txt must name checkout's traffic share"

echo "Step 1 OK."
