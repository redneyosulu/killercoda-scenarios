# Deploy and expose

Create the workload, scale it to three, expose it inside the cluster:

```
kubectl create deployment web --image=nginx:1.25
kubectl scale deployment web --replicas=3
kubectl expose deployment web --port=80 --target-port=80
kubectl get deploy,rs,pods,svc -o wide
```

Wait until all three pods are Running. Then press CHECK: it verifies the deployment has three available replicas and a ClusterIP Service named web exists.
