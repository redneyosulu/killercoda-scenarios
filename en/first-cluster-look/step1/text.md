# Nodes and version

Exam content tracks quarterly Kubernetes releases, so the first habit is version first, always.

Run:

```
kubectl get nodes -o wide
kubectl version
```

Note the Kubernetes version and the node roles (control-plane, worker, or both on one node). Then press CHECK: it verifies at least one node reports Ready.
