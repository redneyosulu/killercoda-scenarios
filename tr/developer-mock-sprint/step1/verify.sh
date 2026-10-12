#!/bin/bash
# Dogrulama: dev-mock icinde api dagitimi, app-cfg configmap, api-sec secret, api-svc servisi.
set -u
NS="dev-mock"
kubectl get namespace "$NS" >/dev/null 2>&1 || { echo "BASARISIZ: $NS isim alani yok."; exit 1; }
kubectl -n "$NS" get deployment api >/dev/null 2>&1 || { echo "BASARISIZ: api dagitimi yok. ~/api.yaml uret ve uygula."; exit 1; }
kubectl -n "$NS" get configmap app-cfg >/dev/null 2>&1 || { echo "BASARISIZ: app-cfg configmap yok."; exit 1; }
kubectl -n "$NS" get secret api-sec >/dev/null 2>&1 || { echo "BASARISIZ: api-sec secret yok."; exit 1; }
kubectl -n "$NS" get service api-svc >/dev/null 2>&1 || { echo "BASARISIZ: api-svc servisi yok. Dagitimi disari ac."; exit 1; }
echo "TAMAM: uygulamadan-disari tahta kuruldu. Tavanlar kagitta, sure basliyor."
