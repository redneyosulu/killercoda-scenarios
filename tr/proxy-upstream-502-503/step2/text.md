# İki kez boz, iki yanı da oku

Önce upstream'i durdur; proksi durumunu ve yanıtlama süresini kaydet (hızlı 502 beklenir). Sonra 503 yanıtlayan veya proksi zaman aşımını aşan asılı kipte başlat (503 veya yavaş 504 beklenir). Durum başına bir proksi ve bir upstream log satırını zaman damgalarıyla alıntıla.

**İpucu:** Upstream uygulamasını durdur (kill $(cat UPSTREAM.pid)), hızlı 502 için curl yapıp case502.log dosyasına kaydet; UPSTREAM_MODE=fail503 ile yeniden başlatıp case503.log dosyasına kaydet. Her vaka için bir proxy satırı alıntıla.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
