#!/bin/bash
# dlab-m05-03 step 3
D=/tmp/dlab-m05-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "held 40 MB" "$D/limit.txt" || fail "limit.txt must show surviving the 40MB hold under the limit"
grep -q "usage:" "$D/limit.txt" || fail "limit.txt must record the measured memory usage"
grep -q "OOMKilled: true" "$D/limit.txt" || fail "limit.txt must show the over-allocation was OOM-killed"
grep -q "exit: 137" "$D/limit.txt" || fail "limit.txt must show exit 137 for the OOM container"

echo "Step 3 OK."
