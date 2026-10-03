# Gerçek sağlık kontrolü ekle

Taslak bağımlılığı test eden /ready gerçekle; ölçülmüş ısınmayı kapsayan start-period ile. Isınmadan önce düştüğünü, sonra geçtiğini göster.

**İpucu:** app/Dockerfile dosyasını /ready üzerinde HEALTHCHECK ve ~15sn ısınmayı kapsayan start-period ile yaz. Derle, çalıştır, 503-sonra-200 ısınma saniyesini warmup.txt dosyasına ve sağlıklı durumu healthy.txt dosyasına kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
