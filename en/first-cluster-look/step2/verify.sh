#!/bin/bash
# Verifies: the four control-plane pods exist and run in kube-system.
set -u
MISSING=""
for comp in kube-apiserver etcd kube-scheduler kube-controller-manager; do
  RUNNING=$(kubectl get pods -n kube-system --no-headers 2>/dev/null | grep "$comp" | grep -c " Running")
  if [ "$RUNNING" -lt 1 ]; then
    MISSING="$MISSING $comp"
  fi
done
if [ -n "$MISSING" ]; then
  echo "FAIL: not Running in kube-system:$MISSING"
  exit 1
fi
echo "OK: apiserver, etcd, scheduler and controller-manager all Running."
