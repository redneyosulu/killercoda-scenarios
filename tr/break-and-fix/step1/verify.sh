#!/bin/bash
# Dogrulama: crasher podu var ve Running (bozuk komut degismis).
set -u
DURUM=$(kubectl get pod crasher -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: crasher podu '$DURUM', beklenen Running. Teshi koy, sil, duzgun yeniden kur."; exit 1; }
SAYI=$(kubectl get pod crasher -o jsonpath='{.status.containerStatuses[0].restartCount}' 2>/dev/null)
echo "TAMAM: crasher Running (guncel ornek yeniden baslatma: ${SAYI:-0})."
