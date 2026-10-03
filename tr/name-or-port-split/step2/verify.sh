#!/bin/bash
# dlab-m02-01 step 2
D=/tmp/dlab-m02-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "isim" "$D/split.txt" || fail "split.txt suçlu olarak İSİM katmanını adlandırmalı"
grep -q "200" "$D/direct.txt" || fail "direct.txt doğrudan port 200 kanıtını içermeli"
echo "Step 2 OK."
