#!/bin/bash
# ck-m00-01 adım 2
D=/tmp/ck-m00-01
NOTE="$D/session-note.txt"
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

[ -s "$NOTE" ] || fail "session-note.txt durmalı"
grep -q "kubectl create deployment speed-demo" "$NOTE" || fail "notta kurma komutu görünmeli"
grep -q "kubectl expose .*speed-demo" "$NOTE" || fail "notta dışarı açma komutu görünmeli"
grep -q "kubectl scale .*speed-demo.*replicas" "$NOTE" || fail "notta kopya sayılı ölçekleme komutu görünmeli"
grep -q "kubectl delete .*speed-demo" "$NOTE" || fail "notta silme komutu görünmeli"
kubectl get deployment speed-demo >/dev/null 2>&1 && fail "speed-demo deploymenti silinmiş olmalı"
kubectl get svc speed-demo >/dev/null 2>&1 && fail "speed-demo servisi silinmiş olmalı"

echo "Step 2 OK."
