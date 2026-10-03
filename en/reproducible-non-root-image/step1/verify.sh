#!/bin/bash
# dlab-m05-01 step 1
D=/tmp/dlab-m05-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

docker images -q m05naive:1 | grep -q . || fail "build the m05naive:1 image first"
grep -q "size=" "$D/naive.txt" || fail "naive.txt must record the image size"
grep -q "build_secs=" "$D/naive.txt" || fail "naive.txt must record the full build seconds"
[ "$(docker run --rm m05naive:1 id -u)" = "0" ] || fail "naive image must run as root (UID 0)"

echo "Step 1 OK."
