#!/bin/bash
# Dogrulama: gen-app APP_MODE=prod ve kaynak istekleriyle sunuyor.
set -u
DEG=$(kubectl get deployment gen-app -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="APP_MODE")].value}' 2>/dev/null)
[ "$DEG" = "prod" ] || { echo "BASARISIZ: gen-app uzerinde APP_MODE '$DEG', beklenen 'prod'."; exit 1; }
ISTEK=$(kubectl get deployment gen-app -o jsonpath='{.spec.template.spec.containers[0].resources.requests.cpu}' 2>/dev/null)
[ -n "$ISTEK" ] || { echo "BASARISIZ: gen-app kapsayicisinda CPU istegi yok."; exit 1; }
HAZIR=$(kubectl get pods -l app=gen-app --no-headers 2>/dev/null | grep -c " Running")
[ "$HAZIR" -ge 1 ] || { echo "BASARISIZ: Running gen-app podu yok. Uyguladin mi?"; exit 1; }
echo "TAMAM: degisken ve istekler sunan dagitimda canli."
