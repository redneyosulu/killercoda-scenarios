# Çözüm notları

1. adım: `volumes: [{name: shared, emptyDir: {}}]` birimli pod; ana komut `sh -c "while true; do echo hello from main >> /shared/log.txt; sleep 5; done"`, bağlama `/shared`; yardımcı komut `sh -c "tail -F /shared/log.txt"`, aynı bağlama. `kubectl logs shipper -c sidecar` satırları saniyeler içinde gösterir.

2. adım: kapsayıcı `resources: {requests: {cpu: 100m, memory: 128Mi}, limits: {cpu: 500m, memory: 256Mi}}`. İstekler zamanlama ve HPA matematiğini alır; sınırlar patlama yarıçapını kapatır. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
