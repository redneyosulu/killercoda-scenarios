#!/bin/bash
# ck-m00-01 step 2
D=/tmp/ck-m00-01
NOTE="$D/session-note.txt"
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt must exist"
grep -q "kubectl create deployment speed-demo" "$NOTE" || fail "note must show the create command"
grep -q "kubectl expose .*speed-demo" "$NOTE" || fail "note must show the expose command"
grep -q "kubectl scale .*speed-demo.*replicas" "$NOTE" || fail "note must show the scale command with replicas"
grep -q "kubectl delete .*speed-demo" "$NOTE" || fail "note must show the delete command"
kubectl get deployment speed-demo >/dev/null 2>&1 && fail "deployment speed-demo must be deleted"
kubectl get svc speed-demo >/dev/null 2>&1 && fail "service speed-demo must be deleted"

echo "Step 2 OK."
