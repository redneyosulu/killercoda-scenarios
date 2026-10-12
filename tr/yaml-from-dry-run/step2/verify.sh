#!/bin/bash
# cd-m00-01 adım 2
D=/tmp/cd-m00-01
NOTE="$D/session-note.txt"
NOTYET="henüz tamamlanmadı"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

kubectl get deployment dry-deploy >/dev/null 2>&1 || fail "dry-deploy deploymenti durmalı"
revs=$(kubectl rollout history deployment/dry-deploy 2>/dev/null | tail -n +3 | grep -c . || true)
[ "$revs" -ge 2 ] || fail "geçmişte en az iki revizyon görünmeli (değişiklik ve geri alma)"
[ -s "$NOTE" ] || fail "session-note.txt kaydedilen komutları taşımalı"
grep -q "kubectl set image" "$NOTE" || fail "notta set image komutu görünmeli"
grep -q "kubectl rollout undo" "$NOTE" || fail "notta rollout undo komutu görünmeli"

echo "Step 2 OK."
