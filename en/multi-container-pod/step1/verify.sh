#!/bin/bash
# Verifies: sidecar stdout carries lines written by the main container.
set -u
PHASE=$(kubectl get pod shipper -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: shipper is '$PHASE', want Running."; exit 1; }
kubectl logs shipper -c sidecar 2>/dev/null | grep -q "hello" || { echo "FAIL: sidecar logs carry no shared lines yet. Check the shared volume mounts on both containers."; exit 1; }
MAIN=$(kubectl exec shipper -c main -- cat /shared/log.txt 2>/dev/null | head -1)
[ -n "$MAIN" ] || { echo "FAIL: main container sees no /shared/log.txt."; exit 1; }
echo "OK: one file, two containers, platform-visible logs."
