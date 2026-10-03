#!/bin/bash
# dlab-m01-03 step 2
D=/tmp/dlab-m01-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qi "inode" "$D/split.txt" || fail "split.txt must name inodes as the pressured counter"
echo "Step 2 OK."
