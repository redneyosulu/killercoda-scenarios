#!/bin/bash
# dlab-m06-02 step 3
D=/tmp/dlab-m06-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "env-a: sha256:" "$D/pulls.txt" || fail "pulls.txt must record env A digest"
grep -q "env-b: sha256:" "$D/pulls.txt" || fail "pulls.txt must record env B digest"
a=$(grep -oE "env-a: sha256:[0-9a-f]+" "$D/pulls.txt" | cut -d: -f3)
b=$(grep -oE "env-b: sha256:[0-9a-f]+" "$D/pulls.txt" | cut -d: -f3)
[ -n "$a" ] && [ "$a" = "$b" ] || fail "both environments must resolve the same digest"
grep -q "smoke-a: build three" "$D/pulls.txt" || fail "env A smoke must pass"
grep -q "smoke-b: build three" "$D/pulls.txt" || fail "env B smoke must pass"

echo "Step 3 OK."
