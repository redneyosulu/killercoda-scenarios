#!/bin/bash
# Dogrulama: data-demo talebi var ve Bound (dinamik ya da elle yol).
set -u
DURUM=$(kubectl get pvc data-demo -o jsonpath='{.status.phase}' 2>/dev/null)
[ "$DURUM" = "Bound" ] || { echo "BASARISIZ: data-demo durumu '$DURUM', beklenen Bound."; exit 1; }
BIRIM=$(kubectl get pvc data-demo -o jsonpath='{.spec.volumeName}' 2>/dev/null)
echo "TAMAM: data-demo $BIRIM birimine bagli."
