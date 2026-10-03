#!/bin/bash
# dlab-m08-01 step 3
D=/tmp/dlab-m08-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "job-ok" "$D/job/result.txt" || fail "job must run green as the narrowed identity"
grep -q "exit: 0" "$D/job-proof.txt" || fail "job-proof.txt must record the green run"
grep -qiE "denied|permission|no such|cannot|hata|redded" "$D/deny-proof.txt" || fail "deny-proof.txt must show the old reach denied"

echo "Step 3 OK."
