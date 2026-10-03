#!/bin/bash
# dlab-m07-03 step 1
D=/tmp/dlab-m07-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "trigger|tetik" "$D/RUNBOOK.md" || fail "runbook needs the trigger"
grep -qiE "precondition|önkoşul|onkosul" "$D/RUNBOOK.md" || fail "runbook needs preconditions"
grep -qiE "expect|beklenen" "$D/RUNBOOK.md" || fail "commands need expected outputs"
grep -qiE "decision|karar" "$D/RUNBOOK.md" || fail "runbook needs decision points"
grep -qiE "done|bitiş|bitis|bitti" "$D/RUNBOOK.md" || fail "runbook needs the done condition"
grep -qiE "stop|durma|escalat" "$D/RUNBOOK.md" || fail "runbook needs stop conditions"
git -C "$D" log --oneline | grep -qiE "runbook" || fail "rewritten runbook must be committed"

echo "Step 1 OK."
