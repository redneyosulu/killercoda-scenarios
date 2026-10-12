#!/bin/bash
# Verifies: rollout history of deployment web holds at least 2 revisions.
set -u
REVS=$(kubectl rollout history deployment/web 2>/dev/null | grep -c "revision")
if [ "$REVS" -lt 2 ]; then
  echo "FAIL: only $REVS revision(s) in history, want at least 2. Run set image first."
  exit 1
fi
echo "OK: $REVS revisions in history, the update happened."
