#!/bin/bash
# Dogrulama: shop-internal ClusterIP, shop-node NodePort, uclar dolu.
set -u
T1=$(kubectl get service shop-internal -o jsonpath='{.spec.type}' 2>/dev/null)
T2=$(kubectl get service shop-node -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$T1" = "ClusterIP" ] || { echo "BASARISIZ: shop-internal '$T1', beklenen ClusterIP."; exit 1; }
[ "$T2" = "NodePort" ] || { echo "BASARISIZ: shop-node '$T2', beklenen NodePort."; exit 1; }
UC=$(kubectl get endpoints shop-internal -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: shop-internal uclari bos. Podlar Running mi?"; exit 1; }
echo "TAMAM: canli uclu ClusterIP + NodePort servisleri."
