# Çözüm notları

1. adım: varsayılan sınıfla sağlayıcı PV'yi kurar, bağlama peşinden gelir. Sınıf yoksa elle PV iş görür; kapasite, erişim kipi ve sınıf (ya da iki tarafta sınıfsızlık) uyarsa bağlanır.

2. adım: `--overrides` bayrağı talebi tek seferlik poda takar. Podu silmek PVC'yi saklar; aynı taleple yeniden kurmak aynı birimi geri takar, işaret durur.

3. adım: püf nokta talebi silip birimi silmemek. Released demek veri yönetici kararı bekliyor: incele, sonra `kubectl delete pv`. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
