#!/bin/bash
D=/tmp/dlab-m06-03
for i in $(seq 1 90); do [ -f "$D/.ready" ] && break; sleep 2; done
echo "Environment ready. Open step 1."
