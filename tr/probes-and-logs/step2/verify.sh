#!/bin/bash
# Dogrulama: duo podunda iki kapsayici da hazir (yardimci duzelmis).
set -u
HAZIR=$(kubectl get pod duo -o jsonpath='{.status.containerStatuses[?(@.ready==true)].name}' 2>/dev/null | wc -w)
[ "$HAZIR" -ge 2 ] || { echo "BASARISIZ: duo icinde $HAZIR kapsayici hazir, beklenen 2. Yardimciyi duzelt, yeniden kur."; exit 1; }
echo "TAMAM: iki kapsayici da hazir. Suclu yardimciydi: -c ve -p buldu."
