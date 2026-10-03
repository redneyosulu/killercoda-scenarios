#!/bin/bash
# dlab-m07-01 step 2
D=/tmp/dlab-m07-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qE "req-[0-9]+-[0-9]+" "$D/join.txt" || fail "join.txt must quote the join key (request id)"
rid=$(grep -oE "req-[0-9]+-[0-9]+" "$D/join.txt" | head -1)
grep -q "$rid" "$D/app.log" || fail "the quoted id must exist in the log"
grep -q "inventory: timeout" "$D/join.txt" || fail "join.txt must quote the shared downstream error"

echo "Step 2 OK."
