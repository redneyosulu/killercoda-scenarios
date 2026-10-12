# Break it, roll it back

Push a bad image, confirm the stall, then undo:

```
kubectl set image deployment/web nginx=nginx:9.99-does-not-exist
kubectl rollout status deployment/web
kubectl rollout undo deployment/web
kubectl rollout status deployment/web
kubectl get pods -o wide
```

The status command times out or reports waiting: that is the stall, read it before undoing. CHECK verifies three pods are Running again on a valid image.
