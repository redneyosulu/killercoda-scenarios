# Outside view

Expose the same app two ways and write the full chain for each path:

```
kubectl expose deployment svc-target --name=outside-node --type=NodePort --port=80
```

Then write Ingress `outside-web` routing host `discover.test` to service svc-target. Curl the NodePort from the node and the hostname through ingress (add it to `/etc/hosts` if a controller runs). Write the chain down: client to ingress to service to endpoints to pod. CHECK verifies the NodePort service and the Ingress rule exist.
