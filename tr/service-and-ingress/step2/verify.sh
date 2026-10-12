#!/bin/bash
# Dogrulama: front Ingress one.test->shop-internal ve two.test->blog yonlendiriyor.
set -u
KURALLAR=$(kubectl get ingress front -o jsonpath='{range .spec.rules[*]}{.host}={.http.paths[0].backend.service.name}{"\n"}{end}' 2>/dev/null)
echo "$KURALLAR" | grep -q "one.test=shop-internal" || { echo "BASARISIZ: one.test -> shop-internal kurali yok. Mevcut:"; echo "$KURALLAR"; exit 1; }
echo "$KURALLAR" | grep -q "two.test=blog" || { echo "BASARISIZ: two.test -> blog kurali yok. Mevcut:"; echo "$KURALLAR"; exit 1; }
echo "TAMAM: iki alan kurali dogru arka uclara bakiyor."
