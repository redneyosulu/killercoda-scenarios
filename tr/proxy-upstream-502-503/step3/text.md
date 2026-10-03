# Yalnızca upstream'i düzelt

Sağlıklı upstream'i geri getir, 200'leri doğrula; ss -tlnp ile her portta tam bir dinleyici olduğunu göster. Proksi konfigürasyonuna hiç dokunulmaz.

**İpucu:** Sağlıklı upstream uygulamasını yeniden başlat (ortam kipi yok), 200 cevabını doğrula, ss ile port başına tek dinleyici göster ve proxy.py dosyasının değişmediğini kanıtla (sha256 ile proxy.sha karşılaştır).

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
