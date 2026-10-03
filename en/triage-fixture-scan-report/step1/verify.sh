#!/bin/bash
# dlab-m08-02 step 1
D=/tmp/dlab-m08-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "F001" "$D/triage.md" || fail "triage must rank F001"
grep -q "F002" "$D/triage.md" || fail "triage must rank F002"
grep -q "F003" "$D/triage.md" || fail "triage must rank F003"
grep -qiE "sprint" "$D/triage.md" || fail "triage must name the sprint handful"
grep -qiE "noise|unreachable|ulaşılmaz|gürültü" "$D/triage.md" || fail "triage must separate unreachable noise"
grep -qiE "unfixable|notice|düzeltilemez|bildirim" "$D/triage.md" || fail "triage must note unfixable notices"

echo "Step 1 OK."
