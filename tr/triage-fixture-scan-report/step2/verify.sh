#!/bin/bash
# dlab-m08-02 step 2
D=/tmp/dlab-m08-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "2.32.3" "$D/requirements.txt" || fail "requests must be bumped"
grep -q "2.2.0" "$D/requirements.txt" || fail "urllib3 must be bumped"
grep -q "F001" "$D/fixed.txt" || fail "fixed.txt must show F001 closed"
python3 -c "import json,sys; r=json.load(open('$D/report2.json')); s={f['id']:f.get('status') for f in r}; sys.exit(0 if s.get('F001','').startswith('fixed') and s.get('F002','').startswith('fixed') and s.get('F003','').startswith('fixed') else 1)" || fail "rescan must show F001-F003 fixed"

echo "Step 2 OK."
