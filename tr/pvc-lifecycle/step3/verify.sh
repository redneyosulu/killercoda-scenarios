#!/bin/bash
# Dogrulama: retain-pv Released durumda (talep silinmis, varlik duruyor).
set -u
DURUM=$(kubectl get pv retain-pv -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Released" ] || { echo "BASARISIZ: retain-pv durumu '$DURUM', beklenen Released. Yalniz PVC yi sil."; exit 1; }
POLITIKA=$(kubectl get pv retain-pv -o jsonpath='{.spec.persistentVolumeReclaimPolicy}' 2>/dev/null)
[ "$POLITIKA" = "Retain" ] || { echo "BASARISIZ: geri kazanim '$POLITIKA', beklenen Retain."; exit 1; }
echo "TAMAM: Retain ile Released. Simdi PV yi kendin sil: tutulan kendini temizlemez."
