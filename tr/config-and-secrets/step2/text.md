# Gizli hijyeni

Gizliyi kur, `sec-test` poduna ortam değişkeni olarak bağla (busybox, sleep 3600):

```
kubectl create secret generic db-pass --from-literal=password=s3cr3t-demo
```

Pod DB_PASSWORD değerini bu gizliden okumalı. Kurallar: değeri kendin asla `echo` ya da `printenv` ile yazdırma; bağlantıyı `kubectl describe pod sec-test` ile kanıtla (başvuruyu gösterir, değeri değil) ve içeriden `test -n "$DB_PASSWORD"` koştur. KONTROL başvurunun var ve değişkenin dolu olduğunu, yazdırmadan doğrular.
