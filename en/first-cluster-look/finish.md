# Done: first contact established

You read a cluster the way every later lab starts: version first, control plane inventoried, context proven round-trip.

Keep these three commands as your session opener everywhere: `kubectl get nodes`, `kubectl get pods -n kube-system`, `kubectl config current-context`. Thirty seconds that prevent wrong-cluster disasters.
