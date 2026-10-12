#!/bin/bash
# Verifies: cfg-test sees MODE=prod env and the mounted greeting file.
set -u
PHASE=$(kubectl get pod cfg-test -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: pod cfg-test is '$PHASE', want Running."; exit 1; }
MODE=$(kubectl exec cfg-test -- printenv MODE 2>/dev/null)
[ "$MODE" = "prod" ] || { echo "FAIL: MODE inside pod is '$MODE', want 'prod' from app-literal."; exit 1; }
kubectl exec cfg-test -- cat /etc/greeting/greeting.txt 2>/dev/null | grep -q "hello from file" || { echo "FAIL: mounted file missing or wrong content."; exit 1; }
echo "OK: env from literal, file from volume, both read inside."
