# Solution notes

Step 1: current `kubectl run` creates a Pod, so pod.yaml gets kind Pod directly. On an older client that still makes Deployments, add `--restart=Never` to force Pod kind. The checker reads `kind` from each file, so regenerate any mismatch.

Step 2: under `containers[0]`, add `env: [{name: APP_MODE, value: prod}]` and `resources: {requests: {cpu: 100m, memory: 128Mi}}`. Dry-run validates free; the live check reads the deployment spec, not the file, so applying is mandatory. Seeing this solution is normal in training; the exam is what counts.
