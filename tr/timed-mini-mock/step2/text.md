# İşaretleyerek koş

Üç arızayı ek, zamanlayıcıyı başlat, işaret disipliniyle düzelt:

```
kubectl -n mock-run set image deployment/app-b nginx=nginx:9.99-does-not-exist
kubectl -n mock-run patch service front -p '{"spec":{"selector":{"app":"front-wrong"}}}'
kubectl -n mock-run rollout pause deployment/app-a
```

Sıra serbest ama iki dakikayı aşan takılmayı işaretle, sonra dön. Nedenler: bozuk imaj (güncelleme takılması), ölü seçici (boş uçlar), duraklatılmış güncelleme (durum duraklatıldı der). Üçünü de düzelt: imajı geri al, seçiciyi düzelt, güncellemeyi sürdür. Son beş dakika yalnız doğrulamadır. KONTROL üç düzeltmeyi birden doğrular.
