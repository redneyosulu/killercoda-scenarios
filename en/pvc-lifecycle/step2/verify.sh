#!/bin/bash
# Verifies: writer pod Running and marker file holds the expected string.
set -u
PHASE=$(kubectl get pod writer -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: pod writer phase is '$PHASE', want Running. Recreate it on data-demo."; exit 1; }
CONTENT=$(kubectl exec writer -- cat /data/marker.txt 2>/dev/null)
echo "$CONTENT" | grep -q "storage-survives" || { echo "FAIL: /data/marker.txt does not hold the marker. Write it, delete the pod, recreate, re-read."; exit 1; }
echo "OK: marker survived pod recreation on the same claim."
