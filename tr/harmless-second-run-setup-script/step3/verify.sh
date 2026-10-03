#!/bin/bash
# dlab-m03-02 step 3
D=/tmp/dlab-m03-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

rm -rf "$D/state"
bash "$D/setup.sh" --check >/dev/null 2>&1 && fail "--check must exit nonzero when changes exist"
bash "$D/setup.sh" --check 2>&1 | grep -qi "would" || fail "--check must print what would change"
bash "$D/setup.sh"
bash "$D/setup.sh" --check >/dev/null 2>&1 || fail "--check must exit zero when converged"

echo "Step 3 OK."
