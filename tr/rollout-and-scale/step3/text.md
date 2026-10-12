# Boz, geri al

Bozuk imaj ver, takılmayı gör, sonra geri al:

```
kubectl set image deployment/web nginx=nginx:9.99-does-not-exist
kubectl rollout status deployment/web
kubectl rollout undo deployment/web
kubectl rollout status deployment/web
kubectl get pods -o wide
```

Durum komutu zaman aşımına uğrar ya da bekliyor bildirir: takılma budur, geri almadan önce oku. KONTROL üç podun da geçerli imajla yeniden Running olduğunu doğrular.
