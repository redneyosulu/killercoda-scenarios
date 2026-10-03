#!/bin/bash
# dlab-m06-03 step 3
D=/tmp/dlab-m06-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "deploy-with-narrow:403" "$D/deny.txt" || fail "deny.txt must show the 403 for the removed deploy access"
grep -q '"status": "ok"' "$D/green-run.log" || fail "green run must show status 200 with the narrow token"
grep -qE "deps-feature-[0-9a-f]{4,}" "$D/green-run.log" || fail "green run must use the repaired cache key"
grep -q "GREEN-WITH-REPAIRED-CACHE" "$D/green-run.log" || fail "green run must be recorded"

echo "Step 3 OK."
