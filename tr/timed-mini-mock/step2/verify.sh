#!/bin/bash
# Dogrulama: imaj geri alinmis, secici duzelmis ve uclar canli, guncelleme suruyor.
set -u
NS="mock-run"
BOZUK=$(kubectl -n "$NS" get pods -l app=app-b -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}' 2>/dev/null | grep -c "9.99")
[ "$BOZUK" -eq 0 ] || { echo "BASARISIZ: app-b podlarinda bozuk imaj duruyor."; exit 1; }
UC=$(kubectl -n "$NS" get endpoints front -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: front uclari bos; secici hala yanlis."; exit 1; }
DURAKLI=$(kubectl -n "$NS" get deployment app-a -o jsonpath='{.spec.paused}' 2>/dev/null)
[ "$DURAKLI" != "true" ] || { echo "BASARISIZ: app-a guncellemesi hala duraklatilmis. Surdur."; exit 1; }
echo "TAMAM: uc ariza da duzeldi. Harcanan sure puan kadar skordur."
