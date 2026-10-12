#!/bin/bash
# Dogrulama: sized-app CPU/bellek istek ve sinirlari tasiyor.
set -u
for a in resources.requests.cpu resources.requests.memory resources.limits.cpu resources.limits.memory; do
  D=$(kubectl get deployment sized-app -o jsonpath="{.spec.template.spec.containers[0].$a}" 2>/dev/null)
  [ -n "$D" ] || { echo "BASARISIZ: sized-app kapsayicisinda $a yok."; exit 1; }
done
echo "TAMAM: istekler ve sinirlar konuldu. Istekler zamanlar, sinirlar korur."
