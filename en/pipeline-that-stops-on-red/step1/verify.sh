#!/bin/bash
# dlab-m06-01 step 1
D=/tmp/dlab-m06-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "PIPELINE GREEN" "$D/green-run.log" || fail "green-run.log must end PIPELINE GREEN"
[ "$(wc -l < "$D/stages.txt")" = "5" ] || fail "stages.txt must hold the five timed stage lines"
lc=$(grep -n "PASS lint" "$D/stages.txt" | cut -d: -f1)
bc=$(grep -n "PASS build" "$D/stages.txt" | cut -d: -f1)
[ "${lc:-9}" -lt "${bc:-0}" ] || fail "cheap lint must run before slow build"
grep -q "PASS package" "$D/stages.txt" || fail "package must run on green"

echo "Step 1 OK."
