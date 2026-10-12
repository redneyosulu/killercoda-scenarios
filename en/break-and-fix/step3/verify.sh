#!/bin/bash
# Verifies: both drills hold simultaneously (Running crasher + live endpoints).
set -u
PHASE=$(kubectl get pod crasher -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$PHASE" = "Running" ] || { echo "FAIL: crasher is '$PHASE', want Running."; exit 1; }
EP=$(kubectl get endpoints shop-broken -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: shop-broken endpoints empty."; exit 1; }
echo "OK: both fixes hold. Compare your two rounds: where did minutes go?"
