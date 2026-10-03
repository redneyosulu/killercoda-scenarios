#!/bin/bash
# dlab-m08-03 step 3
D=/tmp/dlab-m08-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qE "rate=0%" "$D/recovery.csv" || fail "recovery sample must show zero errors"
grep -qx "v1" "$D/version-now.txt" || fail "fixture must serve v1 again"
grep -qiE "detect" "$D/drill-report.md" || fail "report needs detection time"
grep -qiE "rollback|geri al" "$D/drill-report.md" || fail "report needs rollback time"
grep -qiE "recover|kurtar" "$D/drill-report.md" || fail "report needs the recovery proof"
grep -qiE "next|v3|must change|değiş" "$D/drill-report.md" || fail "report must say what the next fix changes"

echo "Step 3 OK."
