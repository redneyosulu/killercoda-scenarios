#!/bin/bash
# dlab-m05-02 step 3
D=/tmp/dlab-m05-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q '"v":"here"' "$D/proof.txt" || fail "proof.txt must show the row read back after db recreation"
grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$D/proof.txt" || fail "proof.txt must show the db IP from in-container resolution"
grep -q "pgdata" "$D/proof.txt" || fail "proof.txt must show the surviving named volume"

echo "Step 3 OK."
