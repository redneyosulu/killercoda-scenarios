#!/bin/bash
# ck-m00-01 adım 3
NOTE=/tmp/ck-m00-01/session-note.txt
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt durmalı"
grep -q "alias k=kubectl" "$NOTE" || fail "notta alias k=kubectl satırı olmalı"
grep -q "kubectl completion" "$NOTE" || fail "notta tamamlama satırı olmalı"
grep -q "dry-run=client" "$NOTE" || fail "notta dry-run kalıbı olmalı"
grep -q "kubectl explain" "$NOTE" || fail "notta kubectl explain sorgusu olmalı"
kubectl create deployment probe --image=nginx -o yaml --dry-run=client 2>/dev/null | grep -q "kind: Deployment" || fail "dry-run bir Deployment bildirimi üretmeli"

echo "Step 3 OK."
