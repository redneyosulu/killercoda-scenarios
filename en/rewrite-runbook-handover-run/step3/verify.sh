#!/bin/bash
# dlab-m07-03 step 3
D=/tmp/dlab-m07-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "DONE-CONDITION-PASS" "$D/run-proof.txt" || fail "run proof must show the verified done condition"
grep -qiE "who" "$D/changelog.txt" || fail "changelog needs who"
grep -qiE "what" "$D/changelog.txt" || fail "changelog needs what"
grep -qiE "when" "$D/changelog.txt" || fail "changelog needs when"
grep -qiE "why|neden" "$D/changelog.txt" || fail "changelog needs why"
grep -qiE "revers|geri al" "$D/changelog.txt" || fail "changelog needs the reversal"

echo "Step 3 OK."
