# Loop it

Apply the files, change the image on the Deployment with `kubectl set image`, verify the rollout, then roll back with `kubectl rollout undo`. Record each command.

**Hint:** `kubectl apply -f /tmp/cd-m00-01/`, then `kubectl set image deployment/dry-deploy nginx=nginx:1.27`, `kubectl rollout status deployment/dry-deploy`, finally `kubectl rollout undo deployment/dry-deploy`. Append every command to the session note.

_When done, press **CHECK** to verify this step._
