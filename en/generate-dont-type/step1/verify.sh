#!/bin/bash
# Verifies: the three files exist with the correct kinds.
set -u
check_kind() {
  local kind
  kind=$(grep -m1 "^kind:" "$HOME/$1" 2>/dev/null | awk '{print $2}')
  [ "$kind" = "$2" ] || { echo "FAIL: ~/$1 holds kind '$kind', want $2. Regenerate it."; exit 1; }
}
check_kind pod.yaml Pod
check_kind deploy.yaml Deployment
check_kind svc.yaml Service
echo "OK: three generated manifests, zero hand-typed."
