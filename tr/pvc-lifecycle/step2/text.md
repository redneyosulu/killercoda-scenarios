# Veri poddan sağ çıkar

Talebi bağla, işaret dosyası yaz, yalnız podu sil, sonra geri oku:

```
kubectl run writer --image=busybox:1.36 --overrides='{"spec":{"containers":[{"name":"writer","image":"busybox:1.36","command":["sh","-c","echo storage-survives > /data/marker.txt && sleep 3600"],"volumeMounts":[{"name":"data","mountPath":"/data"}]}],"volumes":[{"name":"data","persistentVolumeClaim":{"claimName":"data-demo"}}]}}' -- sleep 3600
kubectl exec writer -- cat /data/marker.txt
kubectl delete pod writer
```

Aynı podu (aynı komutla) yeniden kur, işareti tekrar oku. Depolama sorularının sınadığı cümle budur: pod öldü, talep yaşadı, veri sağ çıktı. KONTROL işaretin geri okunduğunu doğrular.
