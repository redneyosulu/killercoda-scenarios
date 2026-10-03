#!/bin/bash
# dlab-m04-02 step 1
D=/tmp/dlab-m04-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -d "$D/author/.git" ] || fail "author clone missing"
[ -d "$D/teammate/.git" ] || fail "teammate clone missing"
git -C "$D/author" log --oneline | grep -qi "9999\|retries" || fail "bad commit missing in author"
git -C "$D/teammate" log --oneline | grep -qi "9999\|retries" || fail "bad commit missing in teammate (pull it)"
[ "$(git -C "$D/author" rev-parse HEAD)" = "$(git -C "$D/teammate" rev-parse HEAD)" ] || fail "both clones must agree on HEAD"

echo "Step 1 OK."
