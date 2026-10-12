#!/bin/bash
# Dogrulama: iki talim de ayni anda tutuyor (Running crasher + canli uclar).
set -u
DURUM=$(kubectl get pod crasher -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: crasher '$DURUM', beklenen Running."; exit 1; }
UC=$(kubectl get endpoints shop-broken -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: shop-broken uclari bos."; exit 1; }
echo "TAMAM: iki duzeltme de tutuyor. Iki turu karsilastir: dakikalar nereye gitti?"
