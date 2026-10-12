# Log kimin

`duo` podunu iki kapsayıcıyla çalıştır: ana kapsayıcı nginx düzgün sunsun, yardımcı busybox `/bin/false` koşsun. Sonra ava çık:

```
kubectl logs duo -c sidecar
kubectl logs duo -c sidecar -p
kubectl get events --sort-by=.lastTimestamp | tail -5
```

Suçlu kapsayıcıyı kanıtla adla, sonra podu iki kapsayıcı da çalışacak şekilde düzelt (yardımcı bozulmak yerine uyusun, yeniden kur). KONTROL iki kapsayıcının da hazır olduğunu doğrular.
