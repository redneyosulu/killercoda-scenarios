#!/bin/bash
# dlab-m08-01 step 2
D=/tmp/dlab-m08-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "fixture-new-0001" "$D/job/secret.key" || fail "narrow channel must hold the rotated value"
[ ! -e "$D/secret/old.key" ] || fail "wide-channel copy must be purged"
grep -qi "rotate" "$D/rotate-log.txt" || fail "log needs the rotate step"
grep -qi "audit" "$D/rotate-log.txt" || fail "log needs the audit step"
grep -qi "purge" "$D/rotate-log.txt" || fail "log needs the purge step"
grep -qi "prevent" "$D/rotate-log.txt" || fail "log needs the prevent step"
[ "$(stat -c %a "$D/job")" = "750" ] || fail "job/ must end at 750"

echo "Step 2 OK."
