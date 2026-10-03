#!/bin/bash
# dlab-m07-03 step 2
D=/tmp/dlab-m07-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "trip|takıl|tereddüt|hesitat|guess|tahmin" "$D/handover.txt" || fail "handover.txt must record trip points"
grep -qiE "fix|düzelt|duzelt" "$D/handover.txt" || fail "every trip point needs its fix"
[ "$(grep -ciE "trip" "$D/handover.txt")" -ge 1 ] || fail "at least one trip point is required"

echo "Step 2 OK."
