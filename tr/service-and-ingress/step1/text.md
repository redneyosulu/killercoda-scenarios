# Üç servis türü

Uygulamayı kur ve üç yolla aç:

```
kubectl create deployment shop --image=nginx:1.25
kubectl expose deployment shop --name=shop-internal --port=80
kubectl expose deployment shop --name=shop-node --type=NodePort --port=80
kubectl get svc,endpoints
```

Test podundan her servisin ClusterIP adresine curl at, hangisinin cevap verdiğini kaydet. Uç listesine dikkat: adlandırmayla yönlendirme arası menteşe. KONTROL iki servisin doğru türde ve uçları dolu olduğunu doğrular.
