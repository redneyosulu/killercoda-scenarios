#!/bin/bash
# Verifies: svc-target resolves by short name and FQDN from the debug pod.
set -u
kubectl exec debug -- nslookup svc-target >/dev/null 2>&1 || { echo "FAIL: short name svc-target does not resolve from debug pod."; exit 1; }
kubectl exec debug -- nslookup svc-target.default.svc.cluster.local >/dev/null 2>&1 || { echo "FAIL: FQDN does not resolve from debug pod."; exit 1; }
echo "OK: short name and FQDN resolve. Short stays local; FQDN travels namespaces."
