#!/bin/bash
# ck-m00-01 adım 1
D=/tmp/ck-m00-01
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get nodes --no-headers 2>/dev/null | grep -qE " Ready" || fail "kubectl get nodes çıktısında Ready düğüm görünmeli"
[ -s "$D/session-note.txt" ] || fail "session-note.txt sürüm satırıyla durmalı"
grep -qE "^k8s-version: v[0-9]+\.[0-9]+" "$D/session-note.txt" || fail "notta k8s-version: vX.Y satırı olmalı"

echo "Step 1 OK."
