# Uygulamadan dışarı sırala

Sürati dev-mock isim alanında kur; yazarlık görevi başına sekiz dakikalık tavanları önce yaz:

```
kubectl create namespace dev-mock
kubectl -n dev-mock create deployment api --image=nginx:1.25 --dry-run=client -o yaml > ~/api.yaml
kubectl -n dev-mock create configmap app-cfg --from-literal=mode=prod --dry-run=client -o yaml > ~/cfg.yaml
kubectl -n dev-mock create secret generic api-sec --from-literal=token=demo --dry-run=client -o yaml > ~/sec.yaml
```

Üçünü de uygula, dağıtımı `api-svc` diye dışarı aç. KONTROL isim alanında dağıtım, configmap, secret ve servisi doğrular.
