#!/bin/bash
# Verifies: miss log maps at least 3 faults to domains with a drill each.
set -u
F="$HOME/miss-log.txt"
[ -f "$F" ] || { echo "FAIL: $F missing. Write one block per fault: domain, class, drill: line."; exit 1; }
DOMAINS=$(grep -oiE "workloads|networking|architecture|storage|troubleshooting" "$F" | sort -u | wc -l)
[ "$DOMAINS" -ge 3 ] || { echo "FAIL: only $DOMAINS distinct domain(s) named, want at least 3."; exit 1; }
DRILLS=$(grep -c "drill:" "$F")
[ "$DRILLS" -ge 3 ] || { echo "FAIL: $DRILLS drill line(s), want at least 3 (one per fault)."; exit 1; }
echo "OK: $DOMAINS domains mapped, $DRILLS drills logged. Next session has its target."
