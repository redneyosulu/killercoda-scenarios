# Zarif durmayı kanıtla

Trafik gönder, konteyneri durdur; uçuşan isteklerin çıkıştan önce tamamlandığını göster. Durdurma süresini kaydet; yeniden kurma döngüsünde 5xx olmadığını doğrula.

**İpucu:** /slow yoluna arka planda istek at, konteyneri stop -t 30 ile durdur, uçuşan isteğin yine 200 döndüğünü ve çıkış kodunun 0 olduğunu kanıtla, durdurma saniyesini drain.txt dosyasına kaydet, sonra yeniden başlatıp / yolunun hâlâ 200 olduğunu göster.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
