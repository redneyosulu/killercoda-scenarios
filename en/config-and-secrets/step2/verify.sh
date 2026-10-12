#!/bin/bash
# Verifies: DB_PASSWORD is wired from db-pass without ever printing the value.
set -u
REF=$(kubectl get pod sec-test -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_PASSWORD")].valueFrom.secretKeyRef.name}' 2>/dev/null)
[ "$REF" = "db-pass" ] || { echo "FAIL: DB_PASSWORD is not wired from secret db-pass."; exit 1; }
kubectl exec sec-test -- sh -c 'test -n "$DB_PASSWORD"' >/dev/null 2>&1 || { echo "FAIL: DB_PASSWORD is empty inside the pod."; exit 1; }
echo "OK: secret wired and non-empty inside; value never printed."
