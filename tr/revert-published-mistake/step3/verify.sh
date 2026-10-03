#!/bin/bash
# dlab-m04-02 step 3
D=/tmp/dlab-m04-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qiE "diverg|behind|ahead|forced|non-fast" "$D/divergence.txt" || fail "divergence.txt must quote the teammate divergence proof"
[ ! -e "$D/author" ] || fail "scratch author clone must be deleted"
[ ! -e "$D/teammate" ] || fail "scratch teammate clone must be deleted"
[ ! -e "$D/remote.git" ] || fail "scratch remote must be deleted"
[ -s "$D/rule.txt" ] || fail "rule.txt must hold the one-sentence rule"
[ "$(wc -l < "$D/rule.txt")" -le 3 ] || fail "the rule is one sentence, not an essay"
grep -qiE "force|reset" "$D/rule.txt" || fail "rule must name the forbidden move (force/reset)"
grep -qiE "shared|payla|ortak|revert|geri al" "$D/rule.txt" || fail "rule must say what shared branches require"

echo "Step 3 OK."
