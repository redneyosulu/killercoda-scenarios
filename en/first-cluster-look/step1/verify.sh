#!/bin/bash
# Verifies: at least one node Ready and the version endpoint answers.
set -u
READY=$(kubectl get nodes --no-headers 2>/dev/null | grep -c " Ready")
if [ "$READY" -lt 1 ]; then
  echo "FAIL: no node in Ready state yet. Wait a moment and retry."
  exit 1
fi
if ! kubectl version --output=json >/dev/null 2>&1; then
  echo "FAIL: kubectl version did not answer. Is kubeconfig pointed at the cluster?"
  exit 1
fi
echo "OK: $READY Ready node(s), version endpoint answers."
