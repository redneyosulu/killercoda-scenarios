#!/bin/bash
# dlab-m05-01 step 3
D=/tmp/dlab-m05-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qx "10001" "$D/idproof.txt" || fail "idproof.txt must show UID 10001 from inside"
grep -q "wrote" "$D/idproof.txt" || fail "idproof.txt must show the write to the app path"
grep -q "REPRODUCIBLE" "$D/rebuild.txt" || fail "rebuild.txt must record the reproducible result"
cmp -s "$D/content1.txt" "$D/content2.txt" || fail "two clean rebuilds must hold byte-identical files"

echo "Step 3 OK."
