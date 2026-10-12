#!/bin/bash
# Verifies: duo pod has both containers ready (sidecar fixed).
set -u
READY=$(kubectl get pod duo -o jsonpath='{.status.containerStatuses[?(@.ready==true)].name}' 2>/dev/null | wc -w)
[ "$READY" -ge 2 ] || { echo "FAIL: $READY containers ready in duo, want 2. Fix the sidecar and recreate."; exit 1; }
echo "OK: both containers ready. The guilty one was the sidecar: -c plus -p found it."
