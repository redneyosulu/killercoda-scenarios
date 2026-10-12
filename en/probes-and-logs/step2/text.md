# Whose log is it

Run pod `duo` with two containers: main nginx serving fine, sidecar busybox running `/bin/false`. Then hunt:

```
kubectl logs duo -c sidecar
kubectl logs duo -c sidecar -p
kubectl get events --sort-by=.lastTimestamp | tail -5
```

Name the guilty container from evidence, then fix the pod so both containers run (recreate with the sidecar sleeping instead of failing). CHECK verifies both containers ready.
