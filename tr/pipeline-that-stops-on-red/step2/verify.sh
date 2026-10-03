#!/bin/bash
# dlab-m06-01 step 2
D=/tmp/dlab-m06-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "FAIL unit" "$D/fail-run.log" || fail "fail-run.log must show the unit stage failing"
grep -q "REJECTED-BY unit" "$D/fail-run.log" || fail "run record must name the rejecting stage"
grep -q "SKIP build" "$D/fail-run.log" || fail "build must be skipped on red"
grep -q "SKIP package" "$D/fail-run.log" || fail "package must be skipped on red"
grep -q "PIPELINE RED" "$D/fail-run.log" || fail "run must end PIPELINE RED"
! grep -q "PIPELINE GREEN" "$D/fail-run.log" || fail "failing run must never print GREEN"

echo "Step 2 OK."
