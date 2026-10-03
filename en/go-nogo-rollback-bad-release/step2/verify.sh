#!/bin/bash
# dlab-m08-03 step 2
D=/tmp/dlab-m08-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qE "rate=[0-9]+" "$D/indicators.csv" || fail "indicators.csv must hold the sampled error rate"
rate=$(grep -oE "rate=[0-9]+" "$D/indicators.csv" | cut -d= -f2)
[ "${rate:-0}" -gt 10 ] || fail "bad release must breach the 10% rollback rule (saw ${rate:-?}%)"
grep -qE "detect_secs=[0-9]+" "$D/timings.txt" || fail "timings.txt must record detection time"
grep -qE "rollback_secs=[0-9]+" "$D/timings.txt" || fail "timings.txt must record rollback time"
[ "$(readlink "$D/current")" = "$D/releases/v1" ] || fail "current must point back at v1"

echo "Step 2 OK."
