# Önce saf sürümü yaz

Üç konfigürasyon satırı ekleyen, iki dizin oluşturan, durum dosyası yazan kurulum betiği yaz. İki kez çalıştır; her çalış sonrası durumu karşılaştır; ikinci karşılaştırma şu an yinelemeyi göstermelidir.

**İpucu:** Bu satırları aynen ekleyen naive.sh dosyasını yaz (SERVER=app, PORT=18083, MODE=prod), data/ ve logs/ oluştur, status yaz. İki kez çalıştır; tekrar kanıtını (sort | uniq -d) dup-proof.txt dosyasına kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
