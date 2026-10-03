#!/bin/bash
# dlab-m06-03 step 1
D=/tmp/dlab-m06-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "status-job" "$D/scopes.yaml" || fail "scopes.yaml must map the status job"
grep -q "deploy-job" "$D/scopes.yaml" || fail "scopes.yaml must map the deploy job"
grep -q "granted" "$D/scopes.yaml" || fail "map must show granted scopes"
grep -q "needed" "$D/scopes.yaml" || fail "map must show minimum-needed scopes"
grep -q "fixture-status-0001" "$D/scopes.yaml" || fail "status job must be narrowed to the status-only token"
grep -qiE "narrow|daralt" "$D/narrow.txt" || fail "narrow.txt must record the narrowing"

echo "Step 1 OK."
