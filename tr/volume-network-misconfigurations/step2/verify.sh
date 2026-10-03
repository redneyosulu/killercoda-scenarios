#!/bin/bash
# dlab-m05-02 step 2
D=/tmp/dlab-m05-02
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

grep -q "pgdata" "$D/compose.yaml" || fail "compose.yaml must hold the named volume"
grep -q "appnet" "$D/compose.yaml" || fail "compose.yaml must hold the shared network"
grep -q "5432:5432" "$D/compose.yaml" && fail "db must not publish 5432 (container-to-container only)" || true
docker ps --format '{{.Names}}' | grep -qi "app" || fail "app container must be Up"
docker ps --format '{{.Names}}' | grep -qi "db" || fail "db container must be Up"
curl -s "http://127.0.0.1:18086/put?k=readiness&v=1" | grep -q "stored" || fail "app must write (db reachable by name)"
curl -s "http://127.0.0.1:18086/get?k=readiness" | grep -q '"v":"1"' || fail "app must read the row back through db by name"

echo "Step 2 OK."
