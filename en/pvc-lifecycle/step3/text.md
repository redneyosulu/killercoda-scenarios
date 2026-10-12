# Reclaim on purpose

Retained volumes are exam traps and real bills. Build one deliberately:

```
mkdir -p /tmp/retain-demo
```

Create PV `retain-pv` (hostPath /tmp/retain-demo, 1Gi, reclaimPolicy Retain), then PVC `retain-demo` with no storage class bound to it. Delete only the PVC and watch the PV: Bound becomes Released, and the asset stays. CHECK verifies the Released state. Afterwards clean up deliberately (`kubectl delete pv retain-pv` plus the directory): retained means manual cleanup, always.
