#!/bin/bash
# ck-m00-02 step 2
D=/tmp/ck-m00-02
NOTE="$D/session-note.txt"
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get pod docs-pod >/dev/null 2>&1 || fail "pod docs-pod must exist"
[ "$(kubectl get pod docs-pod -o jsonpath='{.metadata.labels.edited}' 2>/dev/null)" = "true" ] || fail "pod must carry label edited=true"
[ -s "$NOTE" ] || fail "session-note.txt must record the docs page"
grep -q "https://kubernetes.io/docs" "$NOTE" || fail "note must record the docs page URL used"

echo "Step 2 OK."
