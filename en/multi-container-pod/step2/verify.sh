#!/bin/bash
# Verifies: sized-app carries CPU/memory requests and limits.
set -u
for f in resources.requests.cpu resources.requests.memory resources.limits.cpu resources.limits.memory; do
  V=$(kubectl get deployment sized-app -o jsonpath="{.spec.template.spec.containers[0].$f}" 2>/dev/null)
  [ -n "$V" ] || { echo "FAIL: $f missing on sized-app container."; exit 1; }
done
echo "OK: requests plus limits set. Requests schedule, limits protect."
