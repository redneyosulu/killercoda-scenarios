# Three files, zero typing

Generate all three manifests into your home directory:

```
kubectl run gen-pod --image=nginx:1.25 --dry-run=client -o yaml > ~/pod.yaml
kubectl create deployment gen-app --image=nginx:1.25 --dry-run=client -o yaml > ~/deploy.yaml
kubectl expose deployment gen-app --name=gen-svc --port=80 --dry-run=client -o yaml > ~/svc.yaml
```

CHECK verifies each file exists and carries the correct `kind` (Pod, Deployment, Service). If a file holds the wrong kind, you mixed up the commands: regenerate it.
