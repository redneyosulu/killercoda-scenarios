#!/bin/bash
# dlab-m02-03 step 1
D=/tmp/dlab-m02-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

serving=$(ss -tlnp 2>/dev/null | grep -cE ':(18441|18442|18443) ')
[ "$serving" -ge 3 ] || fail "serve all three fixtures first (ports 18441-18443)"
grep -qi "certificate has expired" "$D/diagnosis.txt" || fail "quote the expired line"
grep -qi "Hostname mismatch" "$D/diagnosis.txt" || fail "quote the wrong-hostname line"
grep -qi "unable to verify the first certificate" "$D/diagnosis.txt" || fail "quote the missing-intermediate line"
echo "Step 1 OK."
