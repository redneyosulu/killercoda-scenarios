#!/bin/bash
# Dogrulama: dort kontrol duzlemi podu kube-system icinde calisiyor.
set -u
EKSIK=""
for bilesen in kube-apiserver etcd kube-scheduler kube-controller-manager; do
  CALISAN=$(kubectl get pods -n kube-system --no-headers 2>/dev/null | grep "$bilesen" | grep -c " Running")
  if [ "$CALISAN" -lt 1 ]; then
    EKSIK="$EKSIK $bilesen"
  fi
done
if [ -n "$EKSIK" ]; then
  echo "BASARISIZ: kube-system icinde calismiyor:$EKSIK"
  exit 1
fi
echo "TAMAM: apiserver, etcd, scheduler ve controller-manager calisiyor."
