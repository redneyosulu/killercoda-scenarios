#!/bin/bash
# ck-m00-02 adım 2
D=/tmp/ck-m00-02
NOTE="$D/session-note.txt"
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get pod docs-pod >/dev/null 2>&1 || fail "docs-pod podu durmalı"
[ "$(kubectl get pod docs-pod -o jsonpath='{.metadata.labels.edited}' 2>/dev/null)" = "true" ] || fail "pod edited=true etiketini taşımalı"
[ -s "$NOTE" ] || fail "session-note.txt belge sayfasını kaydetmeli"
grep -q "https://kubernetes.io/docs" "$NOTE" || fail "notta kullanılan belge adresi olmalı"

echo "Step 2 OK."
