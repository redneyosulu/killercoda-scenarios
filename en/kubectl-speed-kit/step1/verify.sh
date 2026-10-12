#!/bin/bash
# ck-m00-01 step 1
D=/tmp/ck-m00-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get nodes --no-headers 2>/dev/null | grep -qE " Ready" || fail "a Ready node must show in kubectl get nodes"
[ -s "$D/session-note.txt" ] || fail "session-note.txt must exist with your version line"
grep -qE "^k8s-version: v[0-9]+\.[0-9]+" "$D/session-note.txt" || fail "note must hold a k8s-version: vX.Y line"

echo "Step 1 OK."
