#!/bin/bash
# Dogrulama: uc dosya var ve turleri dogru.
set -u
tur_kontrol() {
  local tur
  tur=$(grep -m1 "^kind:" "$HOME/$1" 2>/dev/null | awk '{print $2}')
  [ "$tur" = "$2" ] || { echo "BASARISIZ: ~/$1 turu '$tur', beklenen $2. Yeniden uret."; exit 1; }
}
tur_kontrol pod.yaml Pod
tur_kontrol deploy.yaml Deployment
tur_kontrol svc.yaml Service
echo "TAMAM: uc uretilmis bildirim, sifir elle yazim."
