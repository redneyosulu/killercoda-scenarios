#!/bin/bash
# Verifies: miss log covers all three poles with a drill each.
set -u
F="$HOME/ckad-miss-log.txt"
[ -f "$F" ] || { echo "FAIL: $F missing. One block per miss: pole, domain, drill: line."; exit 1; }
POLES=$(grep -oiE "shape|model|time" "$F" | tr 'A-Z' 'a-z' | sort -u | wc -l)
[ "$POLES" -ge 3 ] || { echo "FAIL: only $POLES distinct pole(s), want all 3 (shape, model, time)."; exit 1; }
DRILLS=$(grep -c "drill:" "$F")
[ "$DRILLS" -ge 3 ] || { echo "FAIL: $DRILLS drill line(s), want at least 3."; exit 1; }
echo "OK: three poles mapped, drills logged. Models transfer; shapes repeat."
