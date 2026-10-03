#!/bin/bash
# dlab-m01-03 step 3
D=/tmp/dlab-m01-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ ! -e "$D" ] || { left=$(find "$D" -type f | wc -l); [ "$left" -eq 0 ] || fail "$left files remain under $D"; }
[ ! -e "$D" ] || fail "$D must be removed at the end"
echo "Step 3 OK."
