# Dynamic provisioning

List the classes and claim storage:

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

If a default class exists, the claim binds on its own: note which provisioner did the work. If no class exists, create a matching hostPath PV by hand (1Gi, ReadWriteOnce) and watch the same binding happen. CHECK verifies the claim is Bound.
