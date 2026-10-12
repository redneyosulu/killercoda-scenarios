# Varsayılan ret

Politikalar eklemeli izin listesidir. Önce varsayılan isim alanında her şeyi kapat, curl'lerin düştüğünü gör, sonra tek akışı aç:

```
kubectl run client --image=busybox:1.36 -- sleep 3600
kubectl run stranger --image=busybox:1.36 -- sleep 3600
```

Tüm podları seçen varsayılan ret giriş politikası uygula. Her iki poddan shop-internal adresine curl at: ikisi de düşer (DNS de düşer; kube-dns adresine 53 portunda izin ver ya da IP kullan). Sonra yalnız `client` poduna izin veren kural ekle, tekrar dene: yalnız istemci cevap verir.

KONTROL varsayılan ret politikasıyla istemciyi adlayan izin politikasını doğrular. Curl kanıtı senin işin; iki poddan da çalıştır.
