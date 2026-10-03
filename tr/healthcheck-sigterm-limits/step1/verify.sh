#!/bin/bash
# dlab-m05-03 step 1
D=/tmp/dlab-m05-03
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

docker inspect -f '{{.Config.Healthcheck.Test}}' m05hc | grep -q "/ready" || fail "image HEALTHCHECK must test /ready"
docker inspect -f '{{.Config.Healthcheck.StartPeriod}}' m05hc | grep -qE '[0-9]{2,}' || fail "HEALTHCHECK needs a start-period covering warmup"
grep -q "early:503" "$D/warmup.txt" || fail "warmup.txt must show the 503 before warm"
grep -q "warmup_secs=" "$D/warmup.txt" || fail "warmup.txt must record the measured warmup seconds"
[ "$(docker inspect --format '{{.State.Health.Status}}' m05hc)" = "healthy" ] || fail "container must be healthy now"
grep -q "health:healthy" "$D/healthy.txt" || fail "healthy.txt must record the healthy state"

echo "Step 1 OK."
