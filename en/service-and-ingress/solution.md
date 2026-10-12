# Solution notes

Step 1: two `kubectl expose` calls with different types on the same deployment. `kubectl get endpoints` shows the selected pod IPs: empty means the selector matches nothing.

Step 2: one Ingress, two rules, each with host plus backend service name and port 80. Without a controller the object still validates; routing needs the controller pod Running.

Step 3: default-deny selects all pods with empty ingress; the allow policy selects shop pods with an ingress from podSelector client. DNS needs its own allow to kube-dns port 53, otherwise even allowed pods fail names. Seeing this solution is normal in training; the exam is what counts.
