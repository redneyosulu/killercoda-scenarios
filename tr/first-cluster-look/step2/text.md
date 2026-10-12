# Kontrol düzlemi envanteri

Kontrol düzlemi podlarını listele:

```
kubectl get pods -n kube-system -o wide
```

kube-apiserver, etcd, kube-scheduler ve kube-controller-manager bileşenlerini bul. Her biri için durursa neyin bozulacağını kendi cümlelerinle söyle. (Zamanlayıcı durursa yeni podlar yerleşmez. Denetleyici durursa istenen durum donar. Etcd durursa tüm okuma yazma durur. Apiserver durursa kubectl ve tüm denetleyiciler körleşir.)

KONTROL dördünün de var ve Running olduğunu doğrular.
