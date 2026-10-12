#!/bin/bash
# Verifies: 3 pods Running on image nginx:1.2x (the rollback landed).
set -u
RUNNING=$(kubectl get pods -l app=web --no-headers 2>/dev/null | grep -c " Running")
if [ "$RUNNING" -lt 3 ]; then
  echo "FAIL: $RUNNING Running pods with label app=web, want 3. Undo and wait."
  exit 1
fi
BAD=$(kubectl get pods -l app=web -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}' 2>/dev/null | grep -c "9.99")
if [ "$BAD" -gt 0 ]; then
  echo "FAIL: bad image still present on pods. The undo did not take effect yet."
  exit 1
fi
echo "OK: 3 Running pods, bad image gone, rollback serves."
