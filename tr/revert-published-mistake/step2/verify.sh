#!/bin/bash
# dlab-m04-02 step 2
D=/tmp/dlab-m04-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

git -C "$D/author" log --oneline | grep -qi "revert" || fail "revert commit missing in author"
git -C "$D/teammate" log --oneline | grep -qi "revert" || fail "teammate must pull the revert"
git -C "$D/author" log --oneline | grep -qi "9999\|retries" || fail "history must still show the bad commit (never rewritten)"
[ "$(git -C "$D/author" rev-parse HEAD)" = "$(git -C "$D/teammate" rev-parse HEAD)" ] || fail "both clones must agree on HEAD"
[ "$(git -C "$D/author" rev-parse HEAD)" = "$(git --git-dir="$D/remote.git" rev-parse refs/heads/main)" ] || fail "remote must match both clones"
git -C "$D/teammate" status -sb | grep -qiE "diverg|behind|ahead" && fail "no divergence allowed after a clean revert" || true

echo "Step 2 OK."
