#!/bin/bash
# Dogrulama: mock-run icinde app-a, app-b, front servisi ve Bound mock-data talebi.
set -u
NS="mock-run"
kubectl get namespace "$NS" >/dev/null 2>&1 || { echo "BASARISIZ: $NS isim alani yok."; exit 1; }
for d in app-a app-b; do
  A=$(kubectl -n "$NS" get deployment "$d" -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
  [ "$A" -ge 1 ] || { echo "BASARISIZ: $NS icinde $d dagitimi hazir degil."; exit 1; }
done
kubectl -n "$NS" get service front >/dev/null 2>&1 || { echo "BASARISIZ: $NS icinde front servisi yok."; exit 1; }
P=$(kubectl -n "$NS" get pvc mock-data -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$P" = "Bound" ] || { echo "BASARISIZ: mock-data talebi '$P', beklenen Bound."; exit 1; }
echo "TAMAM: tahta kuruldu. Butceyi yaz, sonra zamanlayiciyi baslat."
