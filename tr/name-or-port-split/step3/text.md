# Katman sırasında onar

Hosts sabitini kaldır, iki çözümleme aracının 127.0.0.1'de anlaştığını doğrula, sonra portu düzeltip tek başarılı isteği göster. Kayıt kontrol sırasını taşır: önce çözümleyici ayrımı, sonra port testi.

**İpucu:** İğneyi 127.0.0.1 adresine çevir (/etc/hosts dosyasını düzenle, sadece silme), getent ve python aynı cevabı veriyor mu doğrula, sonra svc-lab.test:18080 adresine tek temiz curl yap.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
