# Three service types

Deploy the app and expose it three ways:

```
kubectl create deployment shop --image=nginx:1.25
kubectl expose deployment shop --name=shop-internal --port=80
kubectl expose deployment shop --name=shop-node --type=NodePort --port=80
kubectl get svc,endpoints
```

From a test pod, curl the ClusterIP of each service and record which answers. Note the endpoints list: the hinge between naming and routing. CHECK verifies both services exist with the right types and non-empty endpoints.
