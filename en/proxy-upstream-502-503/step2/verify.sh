#!/bin/bash
# dlab-m02-02 step 2
D=/tmp/dlab-m02-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "502" "$D/case502.log" || fail "case502.log must record the 502"
grep -q "503" "$D/case503.log" || fail "case503.log must record the 503"
grep -q -- "-> 502" "$D/proxy.log" || fail "proxy.log must show the 502 line"
grep -q -- "-> 503" "$D/proxy.log" || fail "proxy.log must show the 503 line"
grep -q -- "-> 503" "$D/upstream.log" || fail "upstream.log must show its 503 line"
grep -q -- "-> 502" "$D/upstream.log" && fail "upstream must have no 502 work of its own" || true
echo "Step 2 OK."
