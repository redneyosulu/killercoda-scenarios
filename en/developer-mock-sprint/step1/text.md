# Sort app-outward

Stage the sprint in namespace dev-mock with eight-minute caps per authoring task written down first:

```
kubectl create namespace dev-mock
kubectl -n dev-mock create deployment api --image=nginx:1.25 --dry-run=client -o yaml > ~/api.yaml
kubectl -n dev-mock create configmap app-cfg --from-literal=mode=prod --dry-run=client -o yaml > ~/cfg.yaml
kubectl -n dev-mock create secret generic api-sec --from-literal=token=demo --dry-run=client -o yaml > ~/sec.yaml
```

Apply all three, then expose the deployment as `api-svc`. CHECK verifies the namespace holds the deployment, the configmap, the secret, and the service.
