#!/bin/bash
# Dogrulama: api dagitimi sondajli, yapilandirma bagli, uclar canli.
set -u
NS="dev-mock"
for s in startupProbe livenessProbe; do
  kubectl -n "$NS" get deployment api -o jsonpath="{.spec.template.spec.containers[0].$s}" 2>/dev/null | grep -q "httpGet" || { echo "BASARISIZ: api uzerinde $s eksik ya da httpGet degil."; exit 1; }
done
kubectl -n "$NS" get deployment api -o jsonpath='{.spec.template.spec.containers[0].envFrom}' 2>/dev/null | grep -q "app-cfg" || { echo "BASARISIZ: app-cfg api ortamına bagli degil."; exit 1; }
UC=$(kubectl -n "$NS" get endpoints api-svc -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: api-svc uclari bos."; exit 1; }
echo "TAMAM: sondajlar uyarlandi, yapilandirma baglandi, uclar canli. Supurme bitti."
