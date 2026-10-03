#!/bin/bash
# dlab-m02-02 step 1
D=/tmp/dlab-m02-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "200" "$D/healthy.txt" || fail "healthy.txt must hold the baseline 200"
grep -q "proxy.log" "$D/logs.txt" || fail "logs.txt must note the proxy log"
grep -q "upstream.log" "$D/logs.txt" || fail "logs.txt must note the upstream log"

echo "Step 1 OK."
