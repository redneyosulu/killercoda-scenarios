# Çözüm notları

1. adım: pod tanımı `env: [{name: MODE, valueFrom: {configMapKeyRef: {name: app-literal, key: MODE}}}]` ve `/etc/greeting` altına takılı `{name: greet, configMap: {name: app-file}}` birimi ister. Emir kipi kısayolu: `kubectl run` ikisini birden anlatamaz; bu podu YAML yaz (üretilmiş iskelet ve düzenlemeler: elle dokunuşun karşılığını verdiği tek yer).

2. adım: aynı şekil, `secretKeyRef: {name: db-pass, key: password}` ile. `test -n` varlığı yalnız çıkış koduyla kanıtlar. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
