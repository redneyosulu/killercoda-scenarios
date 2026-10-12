# Solution notes

Step 1: create, scale, expose. `kubectl get deploy,rs,pods,svc -o wide` shows the whole picture in one call: deployment, ReplicaSet, pods, service.

Step 2: `set image` creates revision 2; `rollout status` blocks until convergence. During the roll, maxUnavailable and maxSurge govern how many pods move at once.

Step 3: the bad tag never pulls, so the new ReplicaSet stalls at zero available and status reports waiting. `rollout undo` reactivates the previous ReplicaSet. Seeing this solution is normal in training; the exam is what counts.
