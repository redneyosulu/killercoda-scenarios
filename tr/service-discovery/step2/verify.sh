#!/bin/bash
# Dogrulama: NodePort servisi ve svc-target yonlendirmeli ingress kurali.
set -u
T=$(kubectl get service outside-node -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$T" = "NodePort" ] || { echo "BASARISIZ: outside-node '$T', beklenen NodePort."; exit 1; }
NP=$(kubectl get service outside-node -o jsonpath='{.spec.ports[0].nodePort}' 2>/dev/null)
[ -n "$NP" ] || { echo "BASARISIZ: outside-node adresinde dugum portu ayrilmamis."; exit 1; }
K=$(kubectl get ingress outside-web -o jsonpath='{range .spec.rules[*]}{.host}={.http.paths[0].backend.service.name}{"\n"}{end}' 2>/dev/null | grep -c "discover.test=svc-target")
[ "$K" -ge 1 ] || { echo "BASARISIZ: discover.test -> svc-target ingress kurali yok."; exit 1; }
echo "TAMAM: $NP dugum portu ayrildi, ingress kurali svc-target adresine bakiyor."
