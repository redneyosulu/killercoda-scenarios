# One ingress, two hosts

Create a second deployment for the second hostname, then one Ingress with two host rules:

```
kubectl create deployment blog --image=nginx:1.25
kubectl expose deployment blog --port=80
```

Write an Ingress named front routing `one.test` to shop-internal and `two.test` to blog. First check whether a controller is present (`kubectl get pods -n ingress-nginx`); if none exists, install ingress-nginx with its official manifest and wait for the controller pod. Then add both names to `/etc/hosts` pointing at the ingress address and curl each hostname.

CHECK verifies the Ingress object carries both host rules with the correct backend services. Live curls are yours to confirm where a controller runs.
