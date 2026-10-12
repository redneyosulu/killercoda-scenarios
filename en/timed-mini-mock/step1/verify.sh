#!/bin/bash
# Verifies: mock-run holds app-a, app-b, service front and a Bound mock-data claim.
set -u
NS="mock-run"
kubectl get namespace "$NS" >/dev/null 2>&1 || { echo "FAIL: namespace $NS missing."; exit 1; }
for d in app-a app-b; do
  A=$(kubectl -n "$NS" get deployment "$d" -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
  [ "$A" -ge 1 ] || { echo "FAIL: deployment $d not available in $NS."; exit 1; }
done
kubectl -n "$NS" get service front >/dev/null 2>&1 || { echo "FAIL: service front missing in $NS."; exit 1; }
P=$(kubectl -n "$NS" get pvc mock-data -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$P" = "Bound" ] || { echo "FAIL: pvc mock-data phase is '$P', want Bound."; exit 1; }
echo "OK: board staged. Write the budget, then start the timer."
