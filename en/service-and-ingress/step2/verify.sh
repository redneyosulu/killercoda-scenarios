#!/bin/bash
# Verifies: Ingress front routes one.test->shop-internal and two.test->blog.
set -u
RULES=$(kubectl get ingress front -o jsonpath='{range .spec.rules[*]}{.host}={.http.paths[0].backend.service.name}{"\n"}{end}' 2>/dev/null)
echo "$RULES" | grep -q "one.test=shop-internal" || { echo "FAIL: rule one.test -> shop-internal missing. Current rules:"; echo "$RULES"; exit 1; }
echo "$RULES" | grep -q "two.test=blog" || { echo "FAIL: rule two.test -> blog missing. Current rules:"; echo "$RULES"; exit 1; }
echo "OK: both host rules point at the correct backends."
