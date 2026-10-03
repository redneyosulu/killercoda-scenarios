#!/bin/bash
D=/tmp/dlab-m03-02
for i in $(seq 1 90); do [ -f "$D/.ready" ] && break; sleep 2; done
echo "Environment ready. Open step 1."
