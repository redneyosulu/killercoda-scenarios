#!/bin/bash
# ck-m00-02 adım 1
NOTE=/tmp/ck-m00-02/session-note.txt
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt üç 'alan: Ns' satırı taşımalı"
n=$(grep -cE '^[^:]+: [0-9]+s$' "$NOTE" || true)
[ "$n" -ge 3 ] || fail "notta en az üç 'alan: Ns' satırı olmalı"
bad=$(grep -Eo '^[^:]+: [0-9]+s$' "$NOTE" | grep -Eo '[0-9]+' | awk '$1>=60' | wc -l)
[ "$bad" -eq 0 ] || fail "her arama 60 saniyenin altında olmalı"

echo "Step 1 OK."
