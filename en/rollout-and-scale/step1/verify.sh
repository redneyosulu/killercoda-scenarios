#!/bin/bash
# Verifies: deployment web has 3 available replicas + ClusterIP service web.
set -u
AVAIL=$(kubectl get deployment web -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
if [ "$AVAIL" != "3" ]; then
  echo "FAIL: deployment web has availableReplicas='$AVAIL', want 3. Scale and wait for pods."
  exit 1
fi
TYPE=$(kubectl get service web -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TYPE" != "ClusterIP" ]; then
  echo "FAIL: service web is type '$TYPE', want ClusterIP. Expose the deployment."
  exit 1
fi
echo "OK: deployment web at 3 available replicas behind ClusterIP service web."
