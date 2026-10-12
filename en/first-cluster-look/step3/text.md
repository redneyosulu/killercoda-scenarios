# Context safety

Wrong-context work scores zero, so prove the round trip:

```
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <another-context>
kubectl config use-context <back-to-the-first>
kubectl get nodes
```

If this cluster has only one context, create a second one pointing at the same cluster (copy with a new name), switch to it, then switch back. The final `get nodes` must answer: that proves you are back in the right place.

CHECK verifies a current context is set, at least one context exists, and the cluster answers.
