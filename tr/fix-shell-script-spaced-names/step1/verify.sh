#!/bin/bash
# dlab-m03-01 step 1
D=/tmp/dlab-m03-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$D/breakage.txt" ] || fail "breakage.txt must quote the failure"
grep -qiE "cannot|no such|error|denied|invalid|copied [45]" "$D/breakage.txt" || fail "quote the wrong count or a cp error line"

echo "Step 1 OK."
