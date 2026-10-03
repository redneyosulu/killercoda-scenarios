#!/bin/bash
# dlab-m03-03 step 1
D=/tmp/dlab-m03-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "ok:200" "$D/endpoints.txt" || fail "endpoints.txt must show /ok 200"
grep -q "limited1:429" "$D/endpoints.txt" || fail "must show the first 429"
grep -q "limited2:429" "$D/endpoints.txt" || fail "must show the second 429"
grep -q "broken:200" "$D/endpoints.txt" || fail "must show /broken answering 200 with bad JSON"

echo "Step 1 OK."
