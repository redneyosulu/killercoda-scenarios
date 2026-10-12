#!/bin/bash
# Verifies: api deployment carries probes, config wiring, and live endpoints.
set -u
NS="dev-mock"
for p in startupProbe livenessProbe; do
  kubectl -n "$NS" get deployment api -o jsonpath="{.spec.template.spec.containers[0].$p}" 2>/dev/null | grep -q "httpGet" || { echo "FAIL: $p missing or not httpGet on api."; exit 1; }
done
kubectl -n "$NS" get deployment api -o jsonpath='{.spec.template.spec.containers[0].envFrom}' 2>/dev/null | grep -q "app-cfg" || { echo "FAIL: app-cfg not wired into api env."; exit 1; }
EP=$(kubectl -n "$NS" get endpoints api-svc -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: api-svc endpoints empty."; exit 1; }
echo "OK: probes fitted, config wired, endpoints live. Sweep done."
