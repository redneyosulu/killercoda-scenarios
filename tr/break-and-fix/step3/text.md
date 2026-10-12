# Süreli tur

İki arızayı sıfırla, saate karşı yeniden yap: her birine on dakika, işaret kuralı açık.

```
kubectl delete pod crasher
kubectl delete service shop-broken
```

CrashLoop'u yeniden kur, teşhis koy, düzelt. Yanlış seçiciyi yeniden kur, önce uçlardan teşhis koy, düzelt, curl ile kanıtla. Dakikaların gerçekte nereye gittiğini kaydet: açık, antrenman hedefidir. KONTROL iki son durumun aynı anda tuttuğunu doğrular.
