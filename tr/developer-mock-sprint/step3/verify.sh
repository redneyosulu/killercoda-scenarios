#!/bin/bash
# Dogrulama: hata gunlugu uc kutbu talimleriyle kapsiyor.
set -u
F="$HOME/ckad-miss-log.txt"
[ -f "$F" ] || { echo "BASARISIZ: $F yok. Hata basina blok yaz: kutup (sekil, model ya da zaman), alan, drill: satiri."; exit 1; }
KUTUP=$(grep -oiE "sekil|model|zaman|shape|model|time" "$F" | tr 'A-Z' 'a-z' | sort -u | wc -l)
[ "$KUTUP" -ge 3 ] || { echo "BASARISIZ: yalniz $KUTUP farkli kutup, beklenen 3 (sekil, model, zaman)."; exit 1; }
TALIM=$(grep -c "drill:" "$F")
[ "$TALIM" -ge 3 ] || { echo "BASARISIZ: $TALIM talim satiri var, beklenen en az 3."; exit 1; }
echo "TAMAM: uc kutup eslenmis, talimler kaydedilmis. Modeller tasinir; sekiller tekrarlar."
