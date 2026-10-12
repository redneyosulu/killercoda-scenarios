# Solution notes

Step 1: `kubectl get nodes -o wide` shows roles and Ready state; `kubectl version` prints client plus server versions. Record the server minor: exam steps assume it.

Step 2: `kubectl get pods -n kube-system` lists the static control-plane pods. Apiserver serves the API, etcd stores all state, scheduler places new pods, controller-manager reconciles desired state.

Step 3: with a single context, duplicate it first:

```
kubectl config rename-context <current> <current>  # no-op guard, shows the name
kubectl config set-context second --cluster=<same> --user=<same>
kubectl config use-context second
kubectl config use-context <first>
kubectl get nodes
```

Seeing this solution is normal in training; the exam is what counts.
