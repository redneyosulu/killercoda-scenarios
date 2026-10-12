# Farkı düzenle

`~/deploy.yaml` dosyasını aç, kapsayıcıya yalnız iki şey ekle: `APP_MODE=prod` ortam değişkeni ve kaynak istekleri (`cpu: 100m`, `memory: 128Mi`). Sonra uygulamadan önce geçerle:

```
kubectl apply -f ~/deploy.yaml --dry-run=client
kubectl apply -f ~/deploy.yaml -f ~/svc.yaml
kubectl get pods -l app=gen-app
```

Canlı podun ikisini de taşıdığını kanıtla: değişkeni içeriden yazdır, istekleri describe ile göster. KONTROL dağıtımın değişken ve isteklerle sunduğunu doğrular.
