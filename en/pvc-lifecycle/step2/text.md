# Data survives the pod

Mount the claim, write a marker file, delete only the pod, then read it back:

```
kubectl run writer --image=busybox:1.36 --overrides='{"spec":{"containers":[{"name":"writer","image":"busybox:1.36","command":["sh","-c","echo storage-survives > /data/marker.txt && sleep 3600"],"volumeMounts":[{"name":"data","mountPath":"/data"}]}],"volumes":[{"name":"data","persistentVolumeClaim":{"claimName":"data-demo"}}]}}' -- sleep 3600
kubectl exec writer -- cat /data/marker.txt
kubectl delete pod writer
```

Recreate the same pod (same command), then read the marker again. This sentence is what storage questions test: the pod died, the claim lived, the data survived. CHECK verifies the marker reads back.
