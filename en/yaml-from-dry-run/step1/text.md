# Generate everything

Produce three manifests with dry-run only: pod `dry-pod`, deployment `dry-deploy`, ClusterIP service `dry-svc`. Typing YAML by hand is forbidden in this round. Start each file with a comment line holding the exact generator command.

**Hint:** `kubectl create pod dry-pod --image=nginx -o yaml --dry-run=client`, `kubectl create deployment dry-deploy --image=nginx -o yaml --dry-run=client`, `kubectl create service clusterip dry-svc --tcp=80:80 -o yaml --dry-run=client`. Redirect each into `/tmp/cd-m00-01/pod.yaml`, `deploy.yaml`, `svc.yaml` with the command as the first comment line.

_When done, press **CHECK** to verify this step._
