#!/bin/bash
# Verifies: a current context is set and the cluster answers through it.
set -u
CTX=$(kubectl config current-context 2>/dev/null)
if [ -z "$CTX" ]; then
  echo "FAIL: no current context set. Switch back with kubectl config use-context."
  exit 1
fi
COUNT=$(kubectl config get-contexts --no-headers 2>/dev/null | wc -l)
if [ "$COUNT" -lt 1 ]; then
  echo "FAIL: no contexts found in kubeconfig."
  exit 1
fi
if ! kubectl get nodes --no-headers >/dev/null 2>&1; then
  echo "FAIL: cluster does not answer through context '$CTX'."
  exit 1
fi
echo "OK: current context '$CTX', cluster answers."
