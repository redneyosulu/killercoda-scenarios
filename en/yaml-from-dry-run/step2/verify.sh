#!/bin/bash
# cd-m00-01 step 2
D=/tmp/cd-m00-01
NOTE="$D/session-note.txt"
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get deployment dry-deploy >/dev/null 2>&1 || fail "deployment dry-deploy must exist"
revs=$(kubectl rollout history deployment/dry-deploy 2>/dev/null | tail -n +3 | grep -c . || true)
[ "$revs" -ge 2 ] || fail "history must show at least two revisions (change plus rollback)"
[ -s "$NOTE" ] || fail "session-note.txt must hold the recorded commands"
grep -q "kubectl set image" "$NOTE" || fail "note must show the set image command"
grep -q "kubectl rollout undo" "$NOTE" || fail "note must show the rollout undo command"

echo "Step 2 OK."
