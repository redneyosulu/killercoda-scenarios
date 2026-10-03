#!/bin/bash
# dlab-m03-03 step 3
D=/tmp/dlab-m03-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

curl -s http://127.0.0.1:18084/reset >/dev/null
START=$(date +%s); bash "$D/fetch.sh" /slow >/dev/null 2>&1; e1=$?; dt=$(( $(date +%s) - START ))
[ "$e1" != "0" ] || fail "/slow must exit nonzero"
[ "$dt" -lt 60 ] || fail "/slow must stay bounded (took ${dt}s)"
bash "$D/fetch.sh" /limited >/dev/null 2>&1 || fail "/limited must eventually succeed"
[ "$(wc -l < "$D/hits.log")" = "3" ] || fail "/limited must take exactly 3 requests (saw $(wc -l < "$D/hits.log"))"
bash "$D/fetch.sh" /broken >/dev/null 2>&1 && fail "/broken must exit nonzero" || true

echo "Step 3 OK."
