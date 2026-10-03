#!/bin/bash
# dlab-m07-02 step 2
D=/tmp/dlab-m07-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -f "$D/restore/records.txt" ] || fail "restore/ must hold the restored fixtures"
[ -f "$D/restore/migrated.marker" ] || fail "migration must be replayed on the target"
grep -q "records.txt" <(tar -tzf "$D/backup.tar.gz") || fail "backup sanity"
python3 "$D/restore/app.py" --dir "$D/restore" | grep -q "records=4" || fail "reader must serve 4 records from restored data"
[ -f "$D/src/records.txt" ] || fail "src/ must be untouched (restore never overwrites the original)"

echo "Step 2 OK."
