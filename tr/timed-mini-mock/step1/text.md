# Tahtayı kur

mock-run isim alanında altı görevlik tahtayı kur, sonra zamanlayıcı başlamadan alan ağırlıklarından görev dakikalarını kâğıda (ya da not dosyasına) yaz:

```
kubectl create namespace mock-run
kubectl -n mock-run create deployment app-a --image=nginx:1.25
kubectl -n mock-run create deployment app-b --image=nginx:1.25
kubectl -n mock-run expose deployment app-a --name=front --port=80
```

Depolamayı da talep et: mock-run içinde `mock-data` PVC'si 1Gi (sınıf varsa dinamik, yoksa PVC labındaki gibi elle hostPath PV). KONTROL isim alanında iki dağıtım, servis ve Bound talebi doğrular.
