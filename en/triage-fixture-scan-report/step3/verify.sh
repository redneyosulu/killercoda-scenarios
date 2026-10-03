#!/bin/bash
# dlab-m08-02 step 3
D=/tmp/dlab-m08-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -qE "20[23][0-9]-[0-9]{2}-[0-9]{2}" "$D/accepts.md" || fail "accepts need expiry dates"
grep -qiE "owner|sahip|learner" "$D/accepts.md" || fail "accepts need owners"
grep -qiE "unfixable|F060|monitor|düzeltilemez" "$D/accepts.md" || fail "accepts need the unfixable note"

echo "Step 3 OK."
