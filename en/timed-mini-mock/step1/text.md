# Stage the board

Build the six-task board in namespace mock-run, then write per-task minutes from domain weights on paper (or a note file) before starting the timer:

```
kubectl create namespace mock-run
kubectl -n mock-run create deployment app-a --image=nginx:1.25
kubectl -n mock-run create deployment app-b --image=nginx:1.25
kubectl -n mock-run expose deployment app-a --name=front --port=80
```

Claim storage too: PVC `mock-data` 1Gi in mock-run (dynamic if a class exists, hand-made hostPath PV otherwise, as in the PVC lab). CHECK verifies the namespace holds two deployments, the service, and a Bound claim.
