# Solution notes

Step 1: busybox nslookup resolves short names via the pod's search domains and FQDNs directly. No answer means CoreDNS or policy, not the app.

Step 2: NodePort opens the same port on every node. The Ingress rule needs host `discover.test`, backend service svc-target port 80; routing needs a controller, the object validates without one.

Step 3: `kubectl create deployment svc-target` labels pods `app=svc-target`; patch the selector back to it. Curl from debug proves the path, endpoints prove the selection. Seeing this solution is normal in training; the exam is what counts.
