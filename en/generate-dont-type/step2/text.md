# Edit the difference

Open `~/deploy.yaml` and add only two things to the container: environment variable `APP_MODE=prod` and CPU/memory requests (`cpu: 100m`, `memory: 128Mi`). Then validate before committing:

```
kubectl apply -f ~/deploy.yaml --dry-run=client
kubectl apply -f ~/deploy.yaml -f ~/svc.yaml
kubectl get pods -l app=gen-app
```

Prove the live pod carries both: exec-print the env var and describe the requests. CHECK verifies the deployment serves with the env var and requests in place.
