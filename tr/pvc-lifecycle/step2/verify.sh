#!/bin/bash
# Dogrulama: writer podu Running ve isaret dosyasi beklenen dizeyi tutuyor.
set -u
DURUM=$(kubectl get pod writer -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: writer podu '$DURUM', beklenen Running. data-demo ile yeniden kur."; exit 1; }
ICERIK=$(kubectl exec writer -- cat /data/marker.txt 2>/dev/null)
echo "$ICERIK" | grep -q "storage-survives" || { echo "BASARISIZ: /data/marker.txt isareti tutmuyor. Yaz, podu sil, yeniden kur, tekrar oku."; exit 1; }
echo "TAMAM: isaret ayni talepte pod yeniden olusumundan sag cikti."
