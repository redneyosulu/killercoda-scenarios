#!/bin/bash
# Dogrulama: yardimci ciktisi ana kapsayicinin satirlarini tasiyor.
set -u
DURUM=$(kubectl get pod shipper -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: shipper '$DURUM', beklenen Running."; exit 1; }
kubectl logs shipper -c sidecar 2>/dev/null | grep -q "hello" || { echo "BASARISIZ: yardimci loglarinda paylasilan satir yok. Her iki kapsayicida paylasilan birim baglantilarini kontrol et."; exit 1; }
ANA=$(kubectl exec shipper -c main -- cat /shared/log.txt 2>/dev/null | head -1)
[ -n "$ANA" ] || { echo "BASARISIZ: ana kapsayici /shared/log.txt dosyasini gormuyor."; exit 1; }
echo "TAMAM: tek dosya, iki kapsayici, platformda gorunur loglar."
