#!/bin/bash
# Dogrulama: web dagitiminda 3 hazir kopya + ClusterIP web servisi.
set -u
HAZIR=$(kubectl get deployment web -o jsonpath='{.status.availableReplicas}' 2>/dev/null)
if [ "$HAZIR" != "3" ]; then
  echo "BASARISIZ: web dagitiminda availableReplicas='$HAZIR', beklenen 3. Olcekle ve podlari bekle."
  exit 1
fi
TUR=$(kubectl get service web -o jsonpath='{.spec.type}' 2>/dev/null)
if [ "$TUR" != "ClusterIP" ]; then
  echo "BASARISIZ: web servisi '$TUR' turunde, beklenen ClusterIP. Dagitimi disari ac."
  exit 1
fi
echo "TAMAM: web dagitimi 3 hazir kopyayla ClusterIP web servisi arkasinda."
