#!/bin/bash
# dlab-m02-02 step 3
D=/tmp/dlab-m02-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

code=$(curl -s -o /dev/null -m 5 -w '%{http_code}' http://127.0.0.1:18080/)
[ "$code" = "200" ] || fail "must be 200 again (got $code)"
[ "$(ss -tlnp | grep -c ':18080 ')" = "1" ] || fail "exactly one listener must hold 18080"
[ "$(ss -tlnp | grep -c ':18081 ')" = "1" ] || fail "exactly one listener must hold 18081"
[ "$(sha256sum "$D/proxy.py" | awk '{print $1}')" = "$(cat "$D/proxy.sha")" ] || fail "proxy.py must be untouched"

echo "Step 3 OK."
