# Boş uçlar sürati

Seçiciyi bilerek boz, önce uçlardan teşhis koy, düzelt, curl ile kanıtla. Süreli: beş dakika.

```
kubectl patch service svc-target -p '{"spec":{"selector":{"app":"target-wrong"}}}'
kubectl get endpoints svc-target
```

Boş liste teşhisin ta kendisidir, etrafından dolaşılacak belirti değil. Seçiciyi dağıtım etiketine geri düzelt, ayıklama podundan servise curl at, süreyi durdur. KONTROL doğru seçicide canlı uçları doğrular.
