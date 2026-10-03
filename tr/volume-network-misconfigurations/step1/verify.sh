#!/bin/bash
# dlab-m05-02 step 1
D=/tmp/dlab-m05-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "could not translate host name" "$D/failure.txt" || fail "failure.txt must quote the name-resolution failure"

echo "Step 1 OK."
