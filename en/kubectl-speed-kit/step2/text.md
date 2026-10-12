# Imperative sprint

Build the full loop with flags only: deployment `speed-demo` from nginx, expose port 80, scale to 3 replicas, then delete both objects. No YAML files in this round. Append every command you run to the session note.

**Hint:** `kubectl create deployment speed-demo --image=nginx`, `kubectl expose deployment speed-demo --port=80`, `kubectl scale deployment speed-demo --replicas=3`, then `kubectl delete deployment speed-demo` plus `kubectl delete svc speed-demo`. Save each line into the note as you go.

_When done, press **CHECK** to verify this step._
