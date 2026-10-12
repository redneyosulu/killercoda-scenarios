# Çözüm notları

1. adım: busybox nslookup kısa adları podun arama alanlarıyla, tam adları doğrudan çözer. Cevap yoksa CoreDNS ya da politika sorunludur, uygulama değil.

2. adım: NodePort her düğümde aynı portu açar. Ingress kuralı `discover.test` alanı, svc-target arka ucu, 80 portu ister; yönlendirme denetleyici ister, nesne denetleyicisiz de geçerlenir.

3. adım: `kubectl create deployment svc-target` podları `app=svc-target` etiketler; seçiciyi ona geri yama. Ayıklamadan curl yolu, uçlar seçimi kanıtlar. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
