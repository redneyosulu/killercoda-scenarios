# Yaramaz API'yi kur

Yerel dört uç sun: /ok (geçerli JSON), /slow (30 sn uyur), /limited (ilk iki vuruş Retry-After ile 429, sonra ok), /broken (kesik JSON ile 200). Hiçbiri localhost dışına çıkmaz.

**İpucu:** Dört uç noktanın da localhost üzerinde yaşadığını kanıtla: /ok /slow (azami süreyle), /limited üç kez, /broken. Dört durum kodunu endpoints.txt dosyasına kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
