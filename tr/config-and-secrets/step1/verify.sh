#!/bin/bash
# Dogrulama: cfg-test MODE=prod ortamini ve bagli karsilama dosyasini goruyor.
set -u
DURUM=$(kubectl get pod cfg-test -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Running" ] || { echo "BASARISIZ: cfg-test podu '$DURUM', beklenen Running."; exit 1; }
KIP=$(kubectl exec cfg-test -- printenv MODE 2>/dev/null)
[ "$KIP" = "prod" ] || { echo "BASARISIZ: pod icinde MODE '$KIP', app-literal kaynakli 'prod' bekleniyor."; exit 1; }
kubectl exec cfg-test -- cat /etc/greeting/greeting.txt 2>/dev/null | grep -q "hello from file" || { echo "BASARISIZ: bagli dosya eksik ya da icerik yanlis."; exit 1; }
echo "TAMAM: sabit degerden ortam, birimden dosya, ikisi de iceriden okundu."
