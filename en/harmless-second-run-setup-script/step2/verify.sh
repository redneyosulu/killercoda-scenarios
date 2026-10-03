#!/bin/bash
# dlab-m03-02 step 2
D=/tmp/dlab-m03-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -f "$D/setup.sh" ] || fail "write setup.sh first"
cp -r "$D/state" "$D/state.before"
bash "$D/setup.sh"
diff -r "$D/state" "$D/state.before" >/dev/null || fail "second run must be an empty diff"
[ "$(grep -c '^SERVER=app$' "$D/state/app.conf")" = "1" ] || fail "each line exactly once"
[ -z "$(find "$D" -maxdepth 1 -name '*.done' -o -name '*.marker' | head -1)" ] || fail "no marker files: read real state"
rm -rf "$D/state.before"

echo "Step 2 OK."
