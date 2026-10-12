#!/bin/bash
# Verifies: shop-broken selects app=shop and its endpoints are non-empty.
set -u
SEL=$(kubectl get service shop-broken -o jsonpath='{.spec.selector.app}' 2>/dev/null)
[ "$SEL" = "shop" ] || { echo "FAIL: shop-broken selector app='$SEL', want 'shop'."; exit 1; }
EP=$(kubectl get endpoints shop-broken -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: endpoints still empty. Are the shop pods Running and labeled app=shop?"; exit 1; }
echo "OK: selector fixed, endpoints live."
