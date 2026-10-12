#!/bin/bash
# Verifies: shop-internal is ClusterIP, shop-node is NodePort, endpoints non-empty.
set -u
T1=$(kubectl get service shop-internal -o jsonpath='{.spec.type}' 2>/dev/null)
T2=$(kubectl get service shop-node -o jsonpath='{.spec.type}' 2>/dev/null)
[ "$T1" = "ClusterIP" ] || { echo "FAIL: shop-internal is '$T1', want ClusterIP."; exit 1; }
[ "$T2" = "NodePort" ] || { echo "FAIL: shop-node is '$T2', want NodePort."; exit 1; }
EP=$(kubectl get endpoints shop-internal -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null)
[ -n "$EP" ] || { echo "FAIL: shop-internal has empty endpoints. Are the pods Running?"; exit 1; }
echo "OK: ClusterIP + NodePort services with live endpoints."
