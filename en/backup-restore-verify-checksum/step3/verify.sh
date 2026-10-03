#!/bin/bash
# dlab-m07-02 step 3
D=/tmp/dlab-m07-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

s1=$(sha256sum "$D/src/records.txt" | cut -d' ' -f1)
s2=$(sha256sum "$D/restore/records.txt" | cut -d' ' -f1)
[ "$s1" = "$s2" ] || fail "checksums must match (src $s1 vs restored $s2)"
grep -q "$s1" "$D/verify.txt" || fail "verify.txt must quote the matching checksum"
grep -qE "restore_secs=[0-9]+" "$D/verify.txt" || fail "verify.txt must record the wall-clock restore time"
grep -qiE "verdict: *(PASS|FAIL)" "$D/verify.txt" || fail "verify.txt must judge against the RTO with a verdict"
grep -qiE "drill|report|RTO" "$D/verify.txt" || fail "verify.txt must carry the drill report"

echo "Step 3 OK."
