#!/bin/bash
# ck-m00-02 step 1
NOTE=/tmp/ck-m00-02/session-note.txt
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt must hold three 'field: Ns' lines"
n=$(grep -cE '^[^:]+: [0-9]+s$' "$NOTE" || true)
[ "$n" -ge 3 ] || fail "note must hold at least three 'field: Ns' lines"
bad=$(grep -Eo '^[^:]+: [0-9]+s$' "$NOTE" | grep -Eo '[0-9]+' | awk '$1>=60' | wc -l)
[ "$bad" -eq 0 ] || fail "every lookup must be under 60 seconds"

echo "Step 1 OK."
