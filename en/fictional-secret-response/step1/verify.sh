#!/bin/bash
# dlab-m04-03 step 1
D=/tmp/dlab-m04-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

cd "$D/work" || fail "work repo missing"
git log -S 'fictional-sample-0000' --oneline | grep -q . || fail "the sample must be searchable in history (-S finds nothing)"
grep -q 'fictional-sample-0000' "$D/found.txt" || fail "found.txt must quote the sample"
grep -qE '[0-9a-f]{7,}' "$D/found.txt" || fail "found.txt must quote the commit hash"
grep -qiE "fictional|kurgusal|example|örnek" "$D/work/secret-sample.txt" || fail "the file itself must label the sample fictional"
! grep -rqiE "sk-live|ghp_|AKIA|xoxb-|real-secret|prod-key" "$D/work" --include='*' 2>/dev/null || fail "no real-credential-shaped string may appear"

echo "Step 1 OK."
