#!/bin/bash
# cd-m00-01 adım 1
D=/tmp/cd-m00-01
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

for f in pod.yaml deploy.yaml svc.yaml; do
  [ -s "$D/$f" ] || fail "$D içinde $f durmalı"
  head -n 1 "$D/$f" | grep -q "^# kubectl create" || fail "$f üreten komut yorumuyla başlamalı"
done
grep -q "kind: Pod" "$D/pod.yaml" || fail "pod.yaml bir Pod taşımalı"
grep -q "kind: Deployment" "$D/deploy.yaml" || fail "deploy.yaml bir Deployment taşımalı"
grep -q "kind: Service" "$D/svc.yaml" || fail "svc.yaml bir Service taşımalı"
kubectl apply --dry-run=client -f "$D/" >/dev/null 2>&1 || fail "üç dosya istemci doğrulamasından geçmeli"

echo "Step 1 OK."
