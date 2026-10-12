# Solution notes

Step 1: pod with `volumes: [{name: shared, emptyDir: {}}]`, main command `sh -c "while true; do echo hello from main >> /shared/log.txt; sleep 5; done"` with mountPath `/shared`, sidecar command `sh -c "tail -F /shared/log.txt"` with the same mount. `kubectl logs shipper -c sidecar` shows the lines within seconds.

Step 2: container `resources: {requests: {cpu: 100m, memory: 128Mi}, limits: {cpu: 500m, memory: 256Mi}}`. Requests buy scheduling and HPA math; limits cap the blast radius. Seeing this solution is normal in training; the exam is what counts.
