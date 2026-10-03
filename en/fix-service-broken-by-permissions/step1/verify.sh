#!/bin/bash
# dlab-m01-01 step 1
D=/tmp/dlab-m01-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "permission denied" "$D/denial.log" || fail "denial.log must quote the Permission denied line"
[ "$(stat -c %a "$D/app.conf")" = "600" ] || fail "app.conf must still be 600 (repair comes in step 3)"
echo "Step 1 OK."
