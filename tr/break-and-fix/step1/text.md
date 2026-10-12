# CrashLoop talimi

Arızayı kur, sonra düzeltmeden önce döngüyle teşhis koy:

```
kubectl run crasher --image=busybox:1.36 -- /bin/false
kubectl get pods -w
kubectl describe pod crasher
kubectl logs crasher --previous
kubectl get events --sort-by=.lastTimestamp | tail -5
```

Katman hükmünü sesli söyle (bozuk komut, platform değil), sonra düzelt: podu sil, çalışan uyku komutuyla yeniden kur. KONTROL crasher podunun Running olduğunu doğrular.
