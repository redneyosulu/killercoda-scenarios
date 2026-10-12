# İçeriden görünüm

Hedefi kur, aç, ayıklama podundan üç yolla çöz:

```
kubectl create deployment svc-target --image=nginx:1.25
kubectl expose deployment svc-target --port=80
kubectl run debug --image=busybox:1.36 -- sleep 3600
kubectl exec debug -- nslookup svc-target
kubectl exec debug -- nslookup svc-target.default.svc.cluster.local
```

Hangilerinin cevap verdiğini ve hangi biçimin isim alanları arasında bozulacağını kaydet. KONTROL kısa adla tam adın ayıklama podundan çözüldüğünü doğrular.
