#!/bin/bash
# dlab-m06-02 step 2
D=/tmp/dlab-m06-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "IMMUTABLE-DENIED" "$D/freeze.log" || fail "freeze.log must show the denied overwrite"
docker images -q m06v:0.1.1 | grep -q . || fail "0.1.1 must exist for the new bytes"
grep -q "^0.1.0:" "$D/tags.db" || fail "ledger must hold the frozen 0.1.0"
grep -q "^0.1.1:" "$D/tags.db" || fail "ledger must hold the append-only 0.1.1"
n11=$(docker inspect --format '{{.Id}}' m06v:0.1.1); st=$(docker inspect --format '{{.Id}}' m06v:staging); pr=$(docker inspect --format '{{.Id}}' m06v:prod)
[ -n "$n11" ] && [ "$st" = "$n11" ] && [ "$pr" = "$n11" ] || fail "staging and prod must resolve the 0.1.1 digest"

echo "Step 2 OK."
