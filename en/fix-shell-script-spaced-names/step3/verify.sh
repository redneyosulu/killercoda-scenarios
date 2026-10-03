#!/bin/bash
# dlab-m03-01 step 3
D=/tmp/dlab-m03-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "broken.sh" "$D/test.sh" || fail "test.sh must exercise broken.sh"
grep -q "fixed.sh" "$D/test.sh" || fail "test.sh must exercise fixed.sh"
bash "$D/test.sh" >/dev/null 2>&1 || fail "test.sh must exit 0"
for n in 'Q3 report (final).txt' '-leading-dash.log' 'normal.txt'; do
  [ -f "$D/out/$n" ] || fail "out/ is missing $n"
done

echo "Step 3 OK."
