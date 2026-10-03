#!/bin/bash
# dlab-m01-01 step 3
D=/tmp/dlab-m01-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

runuser -u svc -- head -c 20 "$D/app.conf" >/dev/null 2>&1 || fail "svc still cannot read app.conf"
wide=$(find "$D" -type f ! -perm 640 ! -perm 600 ! -perm 400 ! -perm 440 ! -perm 444 -print | head -1)
[ -z "$wide" ] || fail "file wider than 640: $wide"
[ "$(stat -c %a "$D/app.conf")" = "640" ] || fail "app.conf must end at 640"
echo "Step 3 OK."
