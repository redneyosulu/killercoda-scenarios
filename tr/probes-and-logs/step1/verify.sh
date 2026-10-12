#!/bin/bash
# Dogrulama: slow-app Running, sifir yeniden baslatma, tanimda uc sondaj.
set -u
DURUM=$(kubectl get pod slow-app -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: slow-app '$DURUM', beklenen Running. Uykuyu bekle, sonra bak."; exit 1; }
S=$(kubectl get pod slow-app -o jsonpath='{.status.containerStatuses[0].restartCount}' 2>/dev/null)
[ "${S:-0}" = "0" ] || { echo "BASARISIZ: yeniden baslatma $S, beklenen 0. Baslangic sondaji gecikmeyi kapsamamis."; exit 1; }
for s in startupProbe livenessProbe readinessProbe; do
  kubectl get pod slow-app -o jsonpath="{.spec.containers[0].$s}" 2>/dev/null | grep -q "httpGet" || { echo "BASARISIZ: $s eksik ya da httpGet degil."; exit 1; }
done
echo "TAMAM: yavas baslayan sifir yeniden baslatmayla sunuyor, sondaj seti tam."
