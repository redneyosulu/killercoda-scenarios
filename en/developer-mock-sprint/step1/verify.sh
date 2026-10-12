#!/bin/bash
# Verifies: dev-mock holds deployment api, configmap app-cfg, secret api-sec, service api-svc.
set -u
NS="dev-mock"
kubectl get namespace "$NS" >/dev/null 2>&1 || { echo "FAIL: namespace $NS missing."; exit 1; }
kubectl -n "$NS" get deployment api >/dev/null 2>&1 || { echo "FAIL: deployment api missing. Generate and apply ~/api.yaml."; exit 1; }
kubectl -n "$NS" get configmap app-cfg >/dev/null 2>&1 || { echo "FAIL: configmap app-cfg missing."; exit 1; }
kubectl -n "$NS" get secret api-sec >/dev/null 2>&1 || { echo "FAIL: secret api-sec missing."; exit 1; }
kubectl -n "$NS" get service api-svc >/dev/null 2>&1 || { echo "FAIL: service api-svc missing. Expose the deployment."; exit 1; }
echo "OK: app-outward board staged. Caps on paper, timer starts now."
