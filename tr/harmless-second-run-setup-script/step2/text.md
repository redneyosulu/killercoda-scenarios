# Her adımı idempotent yap

Her adımı gerçek duruma karşı kontrol-sonra-değişikliğe çevir (satırlara grep -qxF, dizinlere test -d, dosya içeriklerine cmp). İki kez yeniden çalıştır; ilkten sonraki iki karşılaştırma da boş olmalıdır.

**İpucu:** Sıfır bir state dizininden başla, denetle-sonra-değiştir adımlı setup.sh yaz (grep -qxF, test -d, cmp), işaret dosyası yok. İlkten sonraki iki çalışma boş fark vermeli.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
