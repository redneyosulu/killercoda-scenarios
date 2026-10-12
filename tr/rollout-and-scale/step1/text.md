# Kur ve aç

İş yükünü kur, üçe ölçekle, küme içine aç:

```
kubectl create deployment web --image=nginx:1.25
kubectl scale deployment web --replicas=3
kubectl expose deployment web --port=80 --target-port=80
kubectl get deploy,rs,pods,svc -o wide
```

Üç pod da Running olana dek bekle. Sonra KONTROL'e bas: üç hazır kopyalı deployment ile web adlı ClusterIP servisi doğrular.
