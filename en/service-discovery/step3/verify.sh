#!/bin/bash
# Verifies: svc-target endpoints live again on the deployment's selector.
set -u
EP=$(kubectl get endpoints svc-target -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: svc-target endpoints still empty. Fix the selector to the deployment labels."; exit 1; }
SEL=$(kubectl get service svc-target -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SEL" != "target-wrong" ] || { echo "FAIL: selector still points at target-wrong."; exit 1; }
echo "OK: endpoints live. Five minutes is generous once endpoints come first."
