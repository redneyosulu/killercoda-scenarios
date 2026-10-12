#!/bin/bash
# Dogrulama: gecerli imajla 3 pod Running (geri alma tutmus).
set -u
CALISAN=$(kubectl get pods -l app=web --no-headers 2>/dev/null | grep -c " Running")
if [ "$CALISAN" -lt 3 ]; then
  echo "BASARISIZ: app=web etiketli $CALISAN Running pod var, beklenen 3. Geri al ve bekle."
  exit 1
fi
BOZUK=$(kubectl get pods -l app=web -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}' 2>/dev/null | grep -c "9.99")
if [ "$BOZUK" -gt 0 ]; then
  echo "BASARISIZ: podlarda bozuk imaj duruyor. Geri alma henuz tutmamis."
  exit 1
fi
echo "TAMAM: 3 Running pod, bozuk imaj gitmis, geri alma sunuyor."
