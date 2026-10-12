#!/bin/bash
# Dogrulama: svc-target uclari dagitim secicisiyle yeniden canli.
set -u
UC=$(kubectl get endpoints svc-target -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: svc-target uclari hala bos. Seciciyi dagitim etiketlerine duzelt."; exit 1; }
SECIM=$(kubectl get service svc-target -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SECIM" != "target-wrong" ] || { echo "BASARISIZ: secici hala target-wrong bakiyor."; exit 1; }
echo "TAMAM: uclar canli. Once uclar gelince bes dakika boldur."
