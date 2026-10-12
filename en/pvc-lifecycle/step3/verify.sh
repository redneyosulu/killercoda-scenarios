#!/bin/bash
# Verifies: retain-pv exists in Released phase (claim deleted, asset kept).
set -u
PHASE=$(kubectl get pv retain-pv -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Released" ] || { echo "FAIL: pv retain-pv phase is '$PHASE', want Released. Delete only the PVC."; exit 1; }
POLICY=$(kubectl get pv retain-pv -o jsonpath='{.spec.persistentVolumeReclaimPolicy}' 2>/dev/null)
[ "$POLICY" = "Retain" ] || { echo "FAIL: reclaim policy is '$POLICY', want Retain."; exit 1; }
echo "OK: Released with Retain. Now delete the PV yourself: retained never self-cleans."
