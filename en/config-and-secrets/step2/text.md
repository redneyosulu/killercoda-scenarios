# Secret hygiene

Create the secret and wire it as env into pod `sec-test` (busybox, sleep 3600):

```
kubectl create secret generic db-pass --from-literal=password=s3cr3t-demo
```

The pod must read DB_PASSWORD from that secret. Rules: never `echo` or `printenv` the value yourself; prove wiring with `kubectl describe pod sec-test` (shows the reference, not the value) and by exec-running `test -n "$DB_PASSWORD"` inside. CHECK verifies the reference exists and the variable is non-empty, without printing it.
