#!/bin/bash
# Verifies: pod crasher exists and is Running (broken command replaced).
set -u
PHASE=$(kubectl get pod crasher -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: pod crasher phase is '$PHASE', want Running. Diagnose, delete, recreate fixed."; exit 1; }
RESTARTS=$(kubectl get pod crasher -o jsonpath='{.status.containerStatuses[0].restartCount}' 2>/dev/null)
echo "OK: crasher Running (current instance restarts: ${RESTARTS:-0})."
