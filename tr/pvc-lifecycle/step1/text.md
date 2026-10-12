# Dinamik sağlama

Sınıfları listele, depolama talep et:

```
kubectl get storageclass
kubectl create -f - <<'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-demo
spec:
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 1Gi
EOF
kubectl get pvc data-demo -w
```

Varsayılan sınıf varsa talep kendiliğinden bağlanır: işi yapan sağlayıcının adını not et. Sınıf yoksa uyan hostPath PV'yi elle kur (1Gi, ReadWriteOnce), aynı bağlanmayı izle. KONTROL talebin Bound olduğunu doğrular.
