#!/bin/bash
D=/tmp/cd-m02-01
mkdir -p "$D"
# On kubernetes images the control plane starts with the session; wait for the API.
for i in $(seq 1 60); do kubectl get nodes >/dev/null 2>&1 && break; sleep 5; done
touch "$D/.ready" && chmod 600 "$D/.ready"
