#!/bin/bash
# dlab-m06-01 step 3
D=/tmp/dlab-m06-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "PIPELINE GREEN" "$D/green-run2.log" || fail "fixed run must end PIPELINE GREEN"
grep -q "PIPELINE RED" "$D/fail-run.log" || fail "keep the failing run record (fail-run.log)"
ls "$D"/repo/dist/app-*.tar.gz >/dev/null 2>&1 || fail "package must emit the stamped artifact"
grep -qE "app-[0-9a-f]{7,}-[0-9a-f]{8,}\.tar\.gz" "$D/artifact.txt" || fail "artifact name must stamp commit plus digest"

echo "Step 3 OK."
