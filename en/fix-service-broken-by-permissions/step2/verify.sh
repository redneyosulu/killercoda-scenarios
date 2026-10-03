#!/bin/bash
# dlab-m01-01 step 2
D=/tmp/dlab-m01-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi svc "$D/diagnosis.txt" || fail "name the reader (svc)"
grep -qi root "$D/diagnosis.txt" || fail "name the owner (root)"
grep -qi "640" "$D/diagnosis.txt" || fail "name the chosen mode (640)"
echo "Step 2 OK."
