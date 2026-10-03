#!/bin/bash
D=/tmp/dlab-m07-01
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
python3 - <<'PY'
import json, random
random.seed(701)
D = "/tmp/dlab-m07-01"
lines = []
with open(D + "/metrics.csv", "w") as m:
    m.write("minute,endpoint,total,errors,p99_ms\n")
    for minute in range(30):
        rows = [("products", 200, 0), ("cart", 100, 1 if minute % 7 == 0 else 0)]
        cer = 1 if minute < 10 or minute >= 20 else 40
        rows.append(("checkout", 100, cer))
        for ep, total, err in rows:
            p99 = 180 if ep != "checkout" else (4200 if 10 <= minute < 20 else 220)
            m.write("%d,%s,%d,%d,%d\n" % (minute, ep, total, err, p99))
        if 10 <= minute < 20:
            for n in range(rows[2][2]):
                rid = "req-%02d-%02d" % (minute, n)
                lines.append({"ts": "12:%02d:00" % minute, "req": rid, "endpoint": "checkout",
                              "status": 500, "downstream": "inventory: timeout after 2000ms"})
        else:
            for n in range(rows[2][2]):
                rid = "req-%02d-%02d" % (minute, n)
                lines.append({"ts": "12:%02d:00" % minute, "req": rid, "endpoint": "checkout",
                              "status": 500, "downstream": "payment: card declined"})
with open(D + "/app.log", "w") as f:
    for e in lines:
        f.write(json.dumps(e) + "\n")
print("log lines: %d" % len(lines))
PY

touch "$D/.ready" && chmod 600 "$D/.ready"
