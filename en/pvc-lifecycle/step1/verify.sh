#!/bin/bash
# Verifies: PVC data-demo exists and is Bound (dynamic or manual path).
set -u
PHASE=$(kubectl get pvc data-demo -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Bound" ] || { echo "FAIL: pvc data-demo phase is '$PHASE', want Bound."; exit 1; }
VOL=$(kubectl get pvc data-demo -o jsonpath='{.spec.volumeName}' 2>/dev/null)
echo "OK: data-demo Bound to volume $VOL."
