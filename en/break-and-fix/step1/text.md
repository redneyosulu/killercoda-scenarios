# CrashLoop drill

Create the break, then diagnose with the loop before fixing:

```
kubectl run crasher --image=busybox:1.36 -- /bin/false
kubectl get pods -w
kubectl describe pod crasher
kubectl logs crasher --previous
kubectl get events --sort-by=.lastTimestamp | tail -5
```

State the layer verdict aloud (bad command, not platform), then fix it: delete the pod and recreate it with a working sleep command. CHECK verifies a Running crasher.
