#!/bin/bash
# dlab-m03-03 step 2
D=/tmp/dlab-m03-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "TIMEOUT=" "$D/fetch.sh" || fail "TIMEOUT constant must be visible on top"
grep -q "MAX_ATTEMPTS=" "$D/fetch.sh" || fail "MAX_ATTEMPTS constant must be visible on top"
grep -q "BACKOFF=" "$D/fetch.sh" || fail "BACKOFF constant must be visible on top"
grep -qi "retry-after" "$D/fetch.sh" || fail "fetch.sh must honor Retry-After"
grep -q "jq" "$D/fetch.sh" || fail "fetch.sh must parse with jq"
bash "$D/fetch.sh" /ok | grep -q '"status": "ok"' || fail "fetch.sh /ok must print valid JSON"

echo "Step 2 OK."
