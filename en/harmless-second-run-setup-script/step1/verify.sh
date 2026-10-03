#!/bin/bash
# dlab-m03-02 step 1
D=/tmp/dlab-m03-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "SERVER=app" "$D/dup-proof.txt" || fail "dup-proof.txt must show the duplicated line"

echo "Step 1 OK."
