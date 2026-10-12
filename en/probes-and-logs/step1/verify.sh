#!/bin/bash
# Verifies: slow-app Running, zero restarts, all three probes in spec.
set -u
PHASE=$(kubectl get pod slow-app -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: slow-app is '$PHASE', want Running. Wait out the sleep, then check."; exit 1; }
R=$(kubectl get pod slow-app -o jsonpath='{.status.containerStatuses[0].restartCount}' 2>/dev/null)
[ "${R:-0}" = "0" ] || { echo "FAIL: restartCount is $R, want 0. The startup probe did not cover the delay."; exit 1; }
for p in startupProbe livenessProbe readinessProbe; do
  kubectl get pod slow-app -o jsonpath="{.spec.containers[0].$p}" 2>/dev/null | grep -q "httpGet" || { echo "FAIL: $p missing or not httpGet."; exit 1; }
done
echo "OK: slow starter served with zero restarts, full probe set."
