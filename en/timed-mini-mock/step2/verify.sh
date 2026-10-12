#!/bin/bash
# Verifies: image undone, selector fixed with live endpoints, rollout resumed.
set -u
NS="mock-run"
BAD=$(kubectl -n "$NS" get pods -l app=app-b -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}' 2>/dev/null | grep -c "9.99")
[ "$BAD" -eq 0 ] || { echo "FAIL: bad image still on app-b pods."; exit 1; }
EP=$(kubectl -n "$NS" get endpoints front -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: front endpoints empty; selector still wrong."; exit 1; }
PAUSED=$(kubectl -n "$NS" get deployment app-a -o jsonpath='{.spec.paused}' 2>/dev/null)
[ "$PAUSED" != "true" ] || { echo "FAIL: app-a rollout still paused. Resume it."; exit 1; }
echo "OK: all three faults fixed. Time spent is your score next to points."
