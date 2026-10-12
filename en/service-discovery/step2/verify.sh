#!/bin/bash
# Verifies: NodePort service plus ingress rule to svc-target.
set -u
T=$(kubectl get service outside-node -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$T" = "NodePort" ] || { echo "FAIL: outside-node is '$T', want NodePort."; exit 1; }
NP=$(kubectl get service outside-node -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)
[ -n "$NP" ] || { echo "FAIL: no nodePort allocated on outside-node."; exit 1; }
R=$(kubectl get ingress outside-web -o jsonpath='{range .spec.rules[*]}{.host}={.http.paths[0].backend.service.name}{"\n"}{end}' 2>/dev/null | grep -c "discover.test=svc-target")
[ "$R" -ge 1 ] || { echo "FAIL: ingress rule discover.test -> svc-target missing."; exit 1; }
echo "OK: nodePort $NP allocated, ingress rule points at svc-target."
