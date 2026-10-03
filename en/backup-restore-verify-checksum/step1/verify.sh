#!/bin/bash
# dlab-m07-02 step 1
D=/tmp/dlab-m07-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$D/backup.tar.gz" ] || fail "backup.tar.gz must exist"
tar -tzf "$D/backup.tar.gz" | grep -q "records.txt" || fail "backup must hold the fixtures"
grep -qiE "schema" "$D/backup-meta.txt" || fail "meta must record the schema version"
grep -qiE "0\.3\.0|reader" "$D/backup-meta.txt" || fail "meta must record the reader app version"
grep -qE "RPO.*[0-9]+.*(minute|hour|sec)" "$D/backup-meta.txt" || fail "meta must state a numeric RPO"
grep -qE "RTO.*[0-9]+.*(minute|hour|sec)" "$D/backup-meta.txt" || fail "meta must state a numeric RTO"

echo "Step 1 OK."
