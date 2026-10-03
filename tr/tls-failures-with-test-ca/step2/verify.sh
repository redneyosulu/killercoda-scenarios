#!/bin/bash
# dlab-m02-03 step 2
D=/tmp/dlab-m02-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -f "$D/fullchain.pem" ] || fail "assemble fullchain.pem first"
grep -q "Verify return code: 0" "$D/fixed.txt" || fail "fixed.txt must show return code 0"
openssl verify -CAfile "$D/test-ca.crt" -untrusted "$D/test-int.crt" "$D/leaf-good.crt" >/dev/null 2>&1 || fail "chain must verify under explicit trust"
echo "Step 2 OK."
