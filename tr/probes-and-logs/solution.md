# Çözüm notları

1. adım: kapsayıcı komutu `sh -c "sleep 20; exec nginx -g 'daemon off;'"`. startupProbe `httpGet path / port 80`, `failureThreshold: 8, periodSeconds: 5` ile 40 saniye kapsar. Canlılık ve hazırlık aynı httpGet ile varsayılan zamanlamada. Sıfır yeniden başlatma uyumu kanıtlar.

2. adım: `-c sidecar` kapsayıcıyı seçer; `-p` sonlanmış örneği okur. Düzeltme duo'yu yardımcı komutu `sleep 3600` ile yeniden kurar. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
