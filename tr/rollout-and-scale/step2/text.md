# Donanımlı güncelleme

İmajı değiştir, güncellemenin yakinsamasını izle:

```
kubectl set image deployment/web nginx=nginx:1.26
kubectl rollout status deployment/web
kubectl rollout history deployment/web
```

Güncelleme boyunca kaç podun ayakta kaldığını not et: egzersizin anlamı bu sayıdır. KONTROL geçmişte en az iki revizyon olduğunu doğrular.
