#!/bin/bash
# Dogrulama: hata gunlugu en az 3 arizayi alanlara ve talimlere bagliyor.
set -u
F="$HOME/miss-log.txt"
[ -f "$F" ] || { echo "BASARISIZ: $F yok. Ariza basina blok yaz: alan, sinif, drill: satiri."; exit 1; }
ALAN=$(grep -oiE "workloads|networking|architecture|storage|troubleshooting|mimari|depolama" "$F" | tr 'A-Z' 'a-z' | sort -u | wc -l)
[ "$ALAN" -ge 3 ] || { echo "BASARISIZ: yalniz $ALAN farkli alan adlanmis, beklenen en az 3."; exit 1; }
TALIM=$(grep -c "drill:" "$F")
[ "$TALIM" -ge 3 ] || { echo "BASARISIZ: $TALIM talim satiri var, beklenen en az 3 (ariza basina bir)."; exit 1; }
echo "TAMAM: $ALAN alan eslenmis, $TALIM talim kaydedilmis. Sonraki oturumun hedefi belli."
