#!/bin/bash
# cd-m00-01 step 1
D=/tmp/cd-m00-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

for f in pod.yaml deploy.yaml svc.yaml; do
  [ -s "$D/$f" ] || fail "$f must exist in $D"
  head -n 1 "$D/$f" | grep -q "^# kubectl create" || fail "$f must start with its generator command comment"
done
grep -q "kind: Pod" "$D/pod.yaml" || fail "pod.yaml must hold a Pod"
grep -q "kind: Deployment" "$D/deploy.yaml" || fail "deploy.yaml must hold a Deployment"
grep -q "kind: Service" "$D/svc.yaml" || fail "svc.yaml must hold a Service"
kubectl apply --dry-run=client -f "$D/" >/dev/null 2>&1 || fail "the three files must pass client-side validation"

echo "Step 1 OK."
