#!/bin/bash
# Dogrulama: DB_PASSWORD degeri yazdirilmadan db-pass gizlisinden bagli.
set -u
BASVURU=$(kubectl get pod sec-test -o jsonpath='{.spec.containers[0].env[?(@.name=="DB_PASSWORD")].valueFrom.secretKeyRef.name}' 2>/dev/null)
[ "$BASVURU" = "db-pass" ] || { echo "BASARISIZ: DB_PASSWORD db-pass gizlisine bagli degil."; exit 1; }
kubectl exec sec-test -- sh -c 'test -n "$DB_PASSWORD"' >/dev/null 2>&1 || { echo "BASARISIZ: pod icinde DB_PASSWORD bos."; exit 1; }
echo "TAMAM: gizli bagli ve iceride dolu; deger hic yazdirilmadi."
