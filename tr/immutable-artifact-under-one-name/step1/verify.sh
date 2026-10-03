#!/bin/bash
# dlab-m06-02 step 1
D=/tmp/dlab-m06-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "certified: sha256:" "$D/incident.txt" || fail "incident.txt must record the certified digest"
grep -q "would-ship: sha256:" "$D/incident.txt" || fail "incident.txt must record the would-ship digest"
d1=$(grep -oE "certified: sha256:[0-9a-f]+" "$D/incident.txt" | cut -d: -f3)
d2=$(grep -oE "would-ship: sha256:[0-9a-f]+" "$D/incident.txt" | cut -d: -f3)
[ -n "$d1" ] && [ -n "$d2" ] && [ "$d1" != "$d2" ] || fail "the two digests under one name must differ"

echo "Step 1 OK."
