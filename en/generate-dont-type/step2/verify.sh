#!/bin/bash
# Verifies: gen-app serves with APP_MODE=prod and resource requests set.
set -u
ENV=$(kubectl get deployment gen-app -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="APP_MODE")].value}' 2>/dev/null)
[ "$ENV" = "prod" ] || { echo "FAIL: APP_MODE is '$ENV', want 'prod' on gen-app."; exit 1; }
REQ=$(kubectl get deployment gen-app -o jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}' 2>/dev/null)
[ -n "$REQ" ] || { echo "FAIL: no CPU request on gen-app container."; exit 1; }
READY=$(kubectl get pods -l app=gen-app --no-headers 2>/dev/null | grep -c " Running")
[ "$READY" -ge 1 ] || { echo "FAIL: no Running gen-app pod. Did you apply?"; exit 1; }
echo "OK: env plus requests live on a serving deployment."
