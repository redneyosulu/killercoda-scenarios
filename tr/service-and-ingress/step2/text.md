# Tek ingress, iki host

İkinci alan adı için ikinci dağıtımı kur, sonra iki alan kurallı tek Ingress yaz:

```
kubectl create deployment blog --image=nginx:1.25
kubectl expose deployment blog --port=80
```

Önce denetleyici var mı bak (`kubectl get pods -n ingress-nginx`); yoksa resmi bildirimle ingress-nginx kurup denetleyici podunu bekle. Sonra iki adı da ingress adresine `/etc/hosts` ile ekleyip her alan adına curl at.

KONTROL Ingress nesnesinin iki alan kuralını doğru arka uç servislerle taşıdığını doğrular. Denetleyicinin koştuğu yerde canlı curl senin işin.
