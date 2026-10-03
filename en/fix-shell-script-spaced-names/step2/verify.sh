#!/bin/bash
# dlab-m03-01 step 2
D=/tmp/dlab-m03-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "set -euo pipefail" "$D/fixed.sh" || fail "fixed.sh needs set -euo pipefail"
grep -q '$(ls' "$D/fixed.sh" && fail "fixed.sh must not parse ls" || true
grep -q -- "-- " "$D/fixed.sh" || grep -q -- '"--"' "$D/fixed.sh" || grep -q -- "-- \"" "$D/fixed.sh" || fail "fixed.sh needs -- guards"
[ -z "$(shellcheck -S warning "$D/fixed.sh" 2>&1)" ] || fail "shellcheck must report zero warnings"

echo "Step 2 OK."
