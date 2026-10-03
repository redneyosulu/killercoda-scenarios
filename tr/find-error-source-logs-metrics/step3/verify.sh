#!/bin/bash
# dlab-m07-01 step 3
D=/tmp/dlab-m07-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "500|symptom|belirti" "$D/diagnosis.txt" || fail "diagnosis must state the caller symptom"
grep -qi "inventory" "$D/diagnosis.txt" || fail "diagnosis must name the downstream cause"
grep -qiE "timeout|retry|circuit|fix|düzelt|yön|direction" "$D/diagnosis.txt" || fail "diagnosis must state the evidence-backed fix direction"

echo "Step 3 OK."
