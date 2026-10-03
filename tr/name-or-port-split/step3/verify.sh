#!/bin/bash
# dlab-m02-01 step 3
D=/tmp/dlab-m02-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

getent hosts svc-lab.test | grep -q "127.0.0.1" || fail "resolvers must agree on 127.0.0.1"
grep -q "127.0.0.1 svc-lab.test" /etc/hosts || fail "pin must be corrected to 127.0.0.1 in /etc/hosts"
code=$(curl -s -o /dev/null -m 5 -w '%{http_code}' http://svc-lab.test:18080/)
[ "$code" = "200" ] || fail "one clean request must return 200 (got $code)"
echo "Step 3 OK."
