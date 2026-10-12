# ConfigMap two ways

Create one ConfigMap from a literal and one from a file, then consume them differently in one pod:

```
kubectl create configmap app-literal --from-literal=MODE=prod
echo "hello from file" > ~/greeting.txt
kubectl create configmap app-file --from-file=~/greeting.txt
```

Run pod `cfg-test` (busybox, sleep 3600) with MODE as env from app-literal and the file mounted at `/etc/greeting`. Prove both from inside: `printenv MODE` and `cat /etc/greeting/greeting.txt`. CHECK verifies the same two reads.
