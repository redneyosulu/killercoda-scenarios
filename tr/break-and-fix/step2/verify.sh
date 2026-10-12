#!/bin/bash
# Dogrulama: shop-broken app=shop seciyor, uclari dolu.
set -u
SECIM=$(kubectl get service shop-broken -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SECIM" = "shop" ] || { echo "BASARISIZ: shop-broken secici app='$SECIM', beklenen 'shop'."; exit 1; }
UC=$(kubectl get endpoints shop-broken -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$UC" ] || { echo "BASARISIZ: uclar hala bos. Magaza podlari Running ve app=shop etiketli mi?"; exit 1; }
echo "TAMAM: secici duzeldi, uclar canli."
