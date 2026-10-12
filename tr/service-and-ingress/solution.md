# Çözüm notları

1. adım: aynı dağıtıma türleri farklı iki `kubectl expose`. `kubectl get endpoints` seçilen pod IP'lerini gösterir: boş demek seçici hiçbir şeyle eşleşmiyor.

2. adım: tek Ingress, iki kural; her birinde alan ile arka uç servis adı ve 80 portu. Denetleyicisiz nesne yine geçerlenir; yönlendirme denetleyici podu Running ister.

3. adım: varsayılan ret tüm podları boş girişle seçer; izin politikası mağaza podlarını istemci podSeçicisinden girişle seçer. DNS kendi iznini ister: kube-dns adresine 53 portu, yoksa izinli pod bile ad çözemez. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
