# Çözüm notları

1. adım: dosyalara üç dry-run üretimi, her birine bir uygulama, bir dışarı açma. Her uygulamadan önce yazılan tavanlar: yazarlık sekiz dakika, ayıklama iki.

2. adım: `envFrom: [{configMapRef: {name: app-cfg}}]` ve `env: [{name: API_TOKEN, valueFrom: {secretKeyRef: {name: api-sec, key: token}}}]`, çekmeyi kapsayan startupProbe ve livenessProbe; önce dry-run ile uygula. Uçlar seçimi, describe sondajları kanıtlar.

3. adım: blok örneği: `takılma: sondaj uyarlama / kutup: model / drill: işleyici-etki-şekil kuralını oku sonra bir kez uygula`. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
