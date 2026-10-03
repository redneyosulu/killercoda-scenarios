#!/bin/bash
# dlab-m05-03 step 2
D=/tmp/dlab-m05-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "slow-ok" "$D/drain.txt" || fail "drain.txt must show the in-flight request completed (slow-ok)"
grep -q "exit_code=0" "$D/drain.txt" || fail "container must exit 0 after the drain"
secs=$(grep -oE 'stop_secs=[0-9]+' "$D/drain.txt" | cut -d= -f2)
[ "${secs:-0}" -ge 8 ] || fail "stop must wait out the 10s request (saw ${secs:-?}s)"
grep -q "after_restart:200" "$D/drain.txt" || fail "drain.txt must show / at 200 after restart"

echo "Step 2 OK."
