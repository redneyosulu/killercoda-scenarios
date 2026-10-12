# Çözüm notları

1. adım: güncel `kubectl run` Pod kurar, pod.yaml doğrudan Pod türünü alır. Hâlâ Deployment kuran eski istemcide `--restart=Never` ekle, Pod türünü zorlar. Denetleyici her dosyadan `kind` okur; uymayanı doğru komutla yeniden üret.

2. adım: `containers[0]` altına `env: [{name: APP_MODE, value: prod}]` ve `resources: {requests: {cpu: 100m, memory: 128Mi}}` ekle. Dry-run bedava geçerler; canlı kontrol dosya değil dağıtım tanımı okur, uygulamak şart. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
