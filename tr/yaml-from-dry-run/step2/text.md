# Döngüyü tamamla

Dosyaları uygula, Deployment imajını `kubectl set image` ile değiştir, rolloutu doğrula, `kubectl rollout undo` ile geri al. Her komutu kaydet.

**İpucu:** `kubectl apply -f /tmp/cd-m00-01/`, sonra `kubectl set image deployment/dry-deploy nginx=nginx:1.27`, `kubectl rollout status deployment/dry-deploy`, son olarak `kubectl rollout undo deployment/dry-deploy`. Her komutu oturum notuna ekle.

_Bitince bu adımı doğrulamak için **CHECK** düğmesine bas._
