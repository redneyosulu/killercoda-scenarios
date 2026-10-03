#!/bin/bash
# dlab-m04-03 step 3
D=/tmp/dlab-m04-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

head -1 "$D/order.txt" | grep -qiE "revok|iptal" || fail "first line must be revoke (with the service owner)"
grep -qiE "histor|tarih|filter|purge" "$D/order.txt" || fail "order must include history removal"
grep -qiE "rotat|döndür|dondur" "$D/order.txt" || fail "order must include dependent rotation"
grep -qiE "verify|doğrul|dogrul|postmortem|post-mortem|inceleme" "$D/order.txt" || fail "order must end with verification and postmortem"
grep -qiE "cop|kopy|klon|clone|cach|backup|yaşar|outlive" "$D/order.txt" || fail "order must say why revoke precedes removal (copies survive cleanup)"

echo "Step 3 OK."
