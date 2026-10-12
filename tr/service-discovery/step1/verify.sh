#!/bin/bash
# Dogrulama: svc-target ayiklama podundan kisa ad ve tam adla cozunuyor.
set -u
kubectl exec debug -- nslookup svc-target >/dev/null 2>&1 || { echo "BASARISIZ: kisa ad svc-target ayiklama podundan cozunmuyor."; exit 1; }
kubectl exec debug -- nslookup svc-target.default.svc.cluster.local >/dev/null 2>&1 || { echo "BASARISIZ: tam ad ayiklama podundan cozunmuyor."; exit 1; }
echo "TAMAM: kisa ad ve tam ad cozunuyor. Kisa yerelde kalir; tam ad isim alanlari gezer."
