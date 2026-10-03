# Sağlık, SIGTERM ve Limitlerle Güvenli Durmayı Doğrula

**Ortam.** Ubuntu 24.04, Yaklaşık 50 dakika.

## Ne yapacaksın

- Isınmayı kapsayan gerçek bağımlılık yollu hazır kontrolü eklemek
- Uçuşan istekli zarif SIGTERM boşaltmayı kanıtlamak
- Ölçülmüş tepeden bellek limiti kurup OOM sınırını göstermek

_1. adıma geçmeden terminalde `Environment ready` yazısını bekle. Kurulum arka planda çalışır._
