# Seçici talimi

Uygulamayı kur, sonra servisi bilerek hiçbir şeyle eşleşmeyen etiketlere bakacak şekilde yaz:

```
kubectl create deployment shop --image=nginx:1.25
```

`shop-broken` servisini elle yaz, seçici `app: shop-wrong`, port 80 olsun. Önce uçlardan teşhis koy (`kubectl get endpoints shop-broken` boştur), seçiciyi `app: shop` diye düzelt, ayıklama podundan curl ile kanıtla. KONTROL düzelmiş seçicide uçların dolu olduğunu doğrular.
