# Bilerek geri kazanım

Tutulan birimler sınav tuzağı ve gerçek faturadır. Bilerek bir tane kur:

```
mkdir -p /tmp/retain-demo
```

`retain-pv` PV'sini kur (hostPath /tmp/retain-demo, 1Gi, reclaimPolicy Retain), sonra ona bağlanan `retain-demo` PVC'sini sınıf vermeden kur. Yalnız PVC'yi sil ve PV'yi izle: Bound, Released olur, varlık kalır. KONTROL Released durumunu doğrular. Sonra bilerek temizle (`kubectl delete pv retain-pv` ve dizin): tutulan demek elle temizlik demektir, daima.
