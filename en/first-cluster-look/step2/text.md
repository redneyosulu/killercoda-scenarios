# Control plane inventory

List the control-plane pods:

```
kubectl get pods -n kube-system -o wide
```

Find kube-apiserver, etcd, kube-scheduler and kube-controller-manager. For each one, say in your own words what breaks if it stops. (Scheduler down: new pods never place. Controller-manager down: desired state freezes. Etcd down: all reads and writes stop. Apiserver down: kubectl and every controller go blind.)

CHECK verifies all four pods exist and are Running.
