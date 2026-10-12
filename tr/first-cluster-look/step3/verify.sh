#!/bin/bash
# Dogrulama: guncel baglam kurulu ve kume bu baglamla cevap veriyor.
set -u
BAGLAM=$(kubectl config current-context 2>/dev/null)
if [ -z "$BAGLAM" ]; then
  echo "BASARISIZ: guncel baglam kurulu degil. kubectl config use-context ile geri don."
  exit 1
fi
SAYI=$(kubectl config get-contexts --no-headers 2>/dev/null | wc -l)
if [ "$SAYI" -lt 1 ]; then
  echo "BASARISIZ: kubeconfig icinde baglam bulunamadi."
  exit 1
fi
if ! kubectl get nodes --no-headers >/dev/null 2>&1; then
  echo "BASARISIZ: kume '$BAGLAM' baglamiyla cevap vermiyor."
  exit 1
fi
echo "TAMAM: guncel baglam '$BAGLAM', kume cevap veriyor."
