# Servis ve ingress

Servisler değişen podlara kararlı adres verir; Ingress dış HTTP trafiğini alan adına göre yönlendirir; NetworkPolicy kapalı kalması gerekeni kapatır.

Tek dağıtımı üç yolla açıp test podundan erişimi karşılaştıracak, iki alan adını tek Ingress nesnesiyle yönlendirecek, sonra düşen curl'ler ve cevap veren tek curl ile varsayılan reddi kanıtlayacaksın.
