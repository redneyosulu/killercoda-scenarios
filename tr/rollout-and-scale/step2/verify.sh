#!/bin/bash
# Dogrulama: web dagitimi gecmisinde en az 2 revizyon var.
set -u
REV=$(kubectl rollout history deployment/web 2>/dev/null | grep -c "revision")
if [ "$REV" -lt 2 ]; then
  echo "BASARISIZ: gecmiste $REV revizyon var, beklenen en az 2. Once set image calistir."
  exit 1
fi
echo "TAMAM: gecmiste $REV revizyon, guncelleme olmus."
