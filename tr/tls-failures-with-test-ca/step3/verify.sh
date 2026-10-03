#!/bin/bash
# dlab-m02-03 step 3
D=/tmp/dlab-m02-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "yeniden" "$D/repairs.txt" || fail "tarih/SAN onarımı olarak yeniden düzenlemeyi adlandır"
grep -qi "zincir" "$D/repairs.txt" || fail "tam zincir sunmayı adlandır"
[ -f "$D/TEST-ONLY.txt" ] || fail "CA dizini TEST ONLY etiketli kalmalı"
echo "Step 3 OK."
