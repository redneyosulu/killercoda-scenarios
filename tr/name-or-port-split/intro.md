# Yanlış DNS Kaydını Yanlış Uygulama Portundan Ayır

**Ortam.** Ubuntu 24.04, Yaklaşık 40 dakika.

## Ne yapacaksın

- İki eşzamanlı arızalı hatayı yeniden üretmek: yanlış isim ve yanlış port
- Getent ile dig karşılaştırmasıyla hangi katmanın suçlu olduğunu ikisine de dokunmadan kanıtlamak
- Önce isim katmanını düzeltip portu tam bir kez test etmek

_1. adıma geçmeden terminalde `Environment ready` yazısını bekle. Kurulum arka planda çalışır._
