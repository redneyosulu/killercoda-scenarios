#!/bin/bash
# ck-m00-01 step 3
NOTE=/tmp/ck-m00-01/session-note.txt
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt must exist"
grep -q "alias k=kubectl" "$NOTE" || fail "note must hold alias k=kubectl"
grep -q "kubectl completion" "$NOTE" || fail "note must hold the completion line"
grep -q "dry-run=client" "$NOTE" || fail "note must hold a dry-run template"
grep -q "kubectl explain" "$NOTE" || fail "note must hold a kubectl explain query"
kubectl create deployment probe --image=nginx -o yaml --dry-run=client 2>/dev/null | grep -q "kind: Deployment" || fail "dry-run must render a Deployment manifest"

echo "Step 3 OK."
