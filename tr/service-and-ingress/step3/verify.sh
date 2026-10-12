#!/bin/bash
# Dogrulama: tumunu kapatan giris politikasi + istemciye izin politikasi var.
set -u
SAYI=$(kubectl get networkpolicy --no-headers 2>/dev/null | wc -l)
[ "$SAYI" -ge 2 ] || { echo "BASARISIZ: $SAYI NetworkPolicy bulundu, beklenen en az 2 (ret + izin)."; exit 1; }
kubectl get networkpolicy -o yaml 2>/dev/null | grep -q "podSelector" || { echo "BASARISIZ: politikalarda podSelector yok."; exit 1; }
kubectl get networkpolicy -o yaml 2>/dev/null | grep -q "client" || { echo "BASARISIZ: henuz istemci podunu adlayan politika yok."; exit 1; }
echo "TAMAM: ret ve istemci izin politikalari mevcut. Her iki poddan curl ile dogrula."
