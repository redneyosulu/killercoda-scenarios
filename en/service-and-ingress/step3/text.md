# Default deny

Policies are additive allow-lists. First close everything in the default namespace, confirm curls fail, then open one flow:

```
kubectl run client --image=busybox:1.36 -- sleep 3600
kubectl run stranger --image=busybox:1.36 -- sleep 3600
```

Apply a default-deny ingress policy selecting all pods. Curl shop-internal from both pods: both fail (including DNS, so allow kube-dns on port 53 or use IPs). Then add an allow policy from pod `client` only and curl again: only client answers.

CHECK verifies the default-deny policy exists and an allow policy names the client pod. Your curls are the real proof; run them.
