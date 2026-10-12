# Solution notes

Step 1: container command `sh -c "sleep 20; exec nginx -g 'daemon off;'"`. startupProbe `httpGet path / port 80` with `failureThreshold: 8, periodSeconds: 5` covers 40 seconds. Liveness and readiness share the same httpGet with default timing. Zero restarts proves the fit.

Step 2: `-c sidecar` selects the container; `-p` reads the terminated instance. The fix recreates duo with the sidecar command `sleep 3600`. Seeing this solution is normal in training; the exam is what counts.
