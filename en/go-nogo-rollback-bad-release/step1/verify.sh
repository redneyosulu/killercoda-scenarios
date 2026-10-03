#!/bin/bash
# dlab-m08-03 step 1
D=/tmp/dlab-m08-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "indicator|gösterge" "$D/checklist.md" || fail "checklist needs indicators"
grep -qiE "budget|bütçe|butce" "$D/checklist.md" || fail "checklist needs the error budget"
grep -qiE "rollback|geri al" "$D/checklist.md" || fail "checklist needs the rehearsed rollback"
grep -qiE "staff|nöbet|on-call" "$D/checklist.md" || fail "checklist needs staffing"
grep -qiE "comms|iletişim|iletisim|status page" "$D/checklist.md" || fail "checklist needs the comms draft"
grep -qiE "\bGO\b" "$D/checklist.md" || fail "checklist must record the GO decision"

echo "Step 1 OK."
