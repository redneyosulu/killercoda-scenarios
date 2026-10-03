#!/bin/bash
# dlab-m01-02 step 1
D=/tmp/dlab-m01-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "eighty" "$D/faults.txt" || fail "document fault A (APP_PORT=eighty)"
grep -qi "myapp-old" "$D/faults.txt" || fail "document fault B (myapp-old)"
echo "Step 1 OK."
