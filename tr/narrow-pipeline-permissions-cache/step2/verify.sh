#!/bin/bash
# dlab-m06-03 step 2
D=/tmp/dlab-m06-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "FROM=main" "$D/cache-proof.txt" || fail "cache-proof.txt must show main's marker leaking via the blind key"
grep -qiE "MISS|fail closed|kapal" "$D/cache-proof.txt" || fail "fixed key must fail closed on wrong-branch restore"
grep -qE "deps-feature-[0-9a-f]{4,}" "$D/cache-proof.txt" || fail "proof must show the repaired branch-plus-hash key"

echo "Step 2 OK."
