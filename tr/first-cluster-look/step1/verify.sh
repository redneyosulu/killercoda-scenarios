#!/bin/bash
# Dogrulama: en az bir dugum Ready ve surum ucu cevap veriyor.
set -u
READY=$(kubectl get nodes --no-headers 2>/dev/null | grep -c " Ready")
if [ "$READY" -lt 1 ]; then
  echo "BASARISIZ: henuz Ready durumda dugum yok. Biraz bekleyip tekrar dene."
  exit 1
fi
if ! kubectl version --output=json >/dev/null 2>&1; then
  echo "BASARISIZ: kubectl version cevap vermedi. kubeconfig dogru kumeyi mi gosteriyor?"
  exit 1
fi
echo "TAMAM: $READY Ready dugum, surum ucu cevap veriyor."
