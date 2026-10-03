#!/bin/bash
# dlab-m01-02 step 3
D=/tmp/dlab-m01-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "ExecStart=/tmp/dlab-m01-02/myapp$" "$D/myapp.unit" || fail "unit must point at the real binary"
grep -q "APP_PORT=18082" "$D/app.env" || fail "env must carry the numeric port"
code=$(curl -s -o /dev/null -m 5 -w '%{http_code}' http://127.0.0.1:18082/)
[ "$code" = "200" ] || fail "live check failed (want HTTP 200, got $code)"
grep -q "active, answered on 18082" "$D/boot.log" || fail "boot.log must show the healthy boot"
echo "Step 3 OK."
