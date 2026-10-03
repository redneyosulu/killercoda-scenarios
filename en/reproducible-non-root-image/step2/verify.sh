#!/bin/bash
# dlab-m05-01 step 2
D=/tmp/dlab-m05-01
NOTYET="not yet complete"
fail() { echo "HINT: ${1:-$NOTYET}"; exit 1; }

docker images -q m05proper:1 | grep -q . || fail "build the m05proper:1 image first"
grep -q "size=" "$D/proper.txt" || fail "proper.txt must record the image size"
grep -q "rebuild_secs=" "$D/proper.txt" || fail "proper.txt must record the no-change rebuild seconds"
nb=$(docker inspect -f '{{.Size}}' m05naive:1)
pb=$(docker inspect -f '{{.Size}}' m05proper:1)
[ "$pb" -lt "$nb" ] || fail "proper ($pb) must be smaller than naive ($nb)"
grep -q "python:3.12-slim-bookworm" "$D/proper/Dockerfile" || fail "base must be pinned (python:3.12-slim-bookworm)"
[ "$(grep -c '^FROM' "$D/proper/Dockerfile")" -ge 2 ] || fail "Dockerfile must be multi-stage (two FROM lines)"
grep -q "^USER 10001" "$D/proper/Dockerfile" || fail "Dockerfile must end with numeric USER 10001"
[ -f "$D/proper/.dockerignore" ] || fail ".dockerignore is required"

echo "Step 2 OK."
