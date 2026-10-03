#!/bin/bash
# dlab-m04-03 step 2
D=/tmp/dlab-m04-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$D/impact.txt" ] || fail "impact.txt must hold the three-line assessment"
[ "$(wc -l < "$D/impact.txt")" -ge 3 ] || fail "impact.txt needs at least three lines (what, where, who)"
grep -qiE "main|master|branch|dal" "$D/impact.txt" || fail "impact must name the branch"
grep -qiE "remote|origin|uza" "$D/impact.txt" || fail "impact must say whether the remote received it"
grep -qiE "who|kim|anyone|access|eri" "$D/impact.txt" || fail "impact must say who could have seen it"

echo "Step 2 OK."
