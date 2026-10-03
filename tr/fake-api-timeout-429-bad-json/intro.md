# Sahte API'de Zaman Aşımı, 429 ve Bozuk JSON'u Ele Al

**Ortam.** Ubuntu 24.04, Yaklaşık 50 dakika.

## Ne yapacaksın

- Üç kötü davranışı yerel sunmak: takılma, hız sınırı, bozuk gövdeler
- Her birini zaman aşımları, sınırlı yeniden deneme ve ayrıştırılmış yanıtlarla ele almak
- Her kötü girdiyi testle kapsamak; gerçek kimlik bilgisi kullanmamak

_1. adıma geçmeden terminalde `Environment ready` yazısını bekle. Kurulum arka planda çalışır._
