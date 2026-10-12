#!/bin/bash
D=/tmp/ck-m00-02
mkdir -p "$D"
# Kubernetes imajlarında kontrol düzlemi oturumla birlikte başlar; API beklenir.
for i in $(seq 1 60); do kubectl get nodes >/dev/null 2>&1 && break; sleep 5; done
touch "$D/.ready" && chmod 600 "$D/.ready"
