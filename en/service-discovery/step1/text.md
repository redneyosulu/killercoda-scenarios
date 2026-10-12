# Inside view

Deploy the target, expose it, and resolve it three ways from a debug pod:

```
kubectl create deployment svc-target --image=nginx:1.25
kubectl expose deployment svc-target --port=80
kubectl run debug --image=busybox:1.36 -- sleep 3600
kubectl exec debug -- nslookup svc-target
kubectl exec debug -- nslookup svc-target.default.svc.cluster.local
```

Record which answers and which form would break across namespaces. CHECK verifies the short name and the FQDN both resolve from the debug pod.
