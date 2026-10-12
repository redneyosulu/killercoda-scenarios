# Empty endpoints sprint

Break the selector on purpose, diagnose endpoints-first, fix, prove with curl. Timed: five minutes.

```
kubectl patch service svc-target -p '{"spec":{"selector":{"app":"target-wrong"}}}'
kubectl get endpoints svc-target
```

The empty list is the diagnosis, not a symptom to work around. Fix the selector back to the deployment's label, curl the service from the debug pod, stop the timer. CHECK verifies live endpoints on the correct selector.
