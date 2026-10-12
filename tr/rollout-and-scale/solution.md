# Çözüm notları

1. adım: kur, ölçekle, aç. `kubectl get deploy,rs,pods,svc -o wide` tabloyu tek çağrıda gösterir: dağıtım, ReplicaSet, podlar, servis.

2. adım: `set image` 2. revizyonu kurar; `rollout status` yakınsayana dek bekler. Güncelleme boyunca maxUnavailable ve maxSurge aynı anda kaç podun hareket ettiğini yönetir.

3. adım: bozuk etiket hiç çekilemez, yeni ReplicaSet sıfır hazırda takılır, durum bekliyor bildirir. `rollout undo` önceki ReplicaSet'i etkinleştirir. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
