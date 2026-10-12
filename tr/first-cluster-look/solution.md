# Çözüm notları

1. adım: `kubectl get nodes -o wide` rol ve Ready durumunu, `kubectl version` istemci ve sunucu sürümlerini gösterir. Sunucu küçük sürümü kaydet: sınav adımları onu varsayar.

2. adım: `kubectl get pods -n kube-system` statik kontrol düzlemi podlarını listeler. Apiserver API'yi sunar, etcd tüm durumu saklar, zamanlayıcı yeni podları yerleştirir, denetleyici istenen durumu uzlaştırır.

3. adım: tek bağlam varsa önce kopyala:

```
kubectl config current-context  # adı öğren
kubectl config set-context ikinci --cluster=<aynı> --user=<aynı>
kubectl config use-context ikinci
kubectl config use-context <ilk>
kubectl get nodes
```

Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
