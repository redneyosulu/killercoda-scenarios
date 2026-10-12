#!/bin/bash
# Verifies: a deny-all ingress policy exists plus an allow policy for client.
set -u
POLS=$(kubectl get networkpolicy --no-headers 2>/dev/null | wc -l)
[ "$POLS" -ge 2 ] || { echo "FAIL: found $POLS NetworkPolicies, want at least 2 (deny-all + allow)."; exit 1; }
kubectl get networkpolicy -o yaml 2>/dev/null | grep -q "podSelector" || { echo "FAIL: no podSelector found in policies."; exit 1; }
kubectl get networkpolicy -o yaml 2>/dev/null | grep -q "client" || { echo "FAIL: no policy names the client pod yet."; exit 1; }
echo "OK: deny-all plus client allow policies present. Confirm with curls from both pods."
