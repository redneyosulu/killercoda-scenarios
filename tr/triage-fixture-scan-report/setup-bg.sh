#!/bin/bash
D=/tmp/dlab-m08-02
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; shellcheck) echo shellcheck;; jq) echo jq;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc shellcheck jq; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
python3 - <<'PY'
import json
D = "/tmp/dlab-m08-02"
pkgs = [("requests", "2.28.0", "app"), ("urllib3", "1.26.0", "app"),
        ("openssl", "1.1.1", "base"), ("django", "3.2.0", "app"),
        ("numpy", "1.21.0", "dev"), ("pytest", "6.0.0", "dev")]
out = [
  {"id": "F001", "pkg": "requests", "installed": "2.28.0", "severity": "critical",
   "reachable": True, "exploit": "public PoC", "blast": "credential leak", "area": "app"},
  {"id": "F002", "pkg": "urllib3", "installed": "1.26.0", "severity": "high",
   "reachable": True, "exploit": "public PoC", "blast": "request smuggling", "area": "app"},
  {"id": "F003", "pkg": "openssl", "installed": "1.1.1", "severity": "high",
   "reachable": True, "exploit": "known CVE", "blast": "tls decrypt", "area": "base"},
]
n = 4
for pkg, ver, area in pkgs:
    for k in range(9 if area == "app" else 12):
        sev = ["low", "medium", "medium", "high"][n % 4]
        out.append({"id": "F%03d" % n, "pkg": pkg, "installed": ver, "severity": sev,
                    "reachable": (n % 5 == 0), "exploit": "none known",
                    "blast": "limited", "area": area})
        n += 1
out.append({"id": "F060", "pkg": "kernel-note", "installed": "n/a", "severity": "info",
            "reachable": False, "exploit": "not applicable", "blast": "none",
            "area": "notice"})
json.dump(out, open(D + "/report.json", "w"), indent=1)
print("findings: %d" % len(out))
PY
printf 'requests==2.28.0\nurllib3==1.26.0\n' > "$D/requirements.txt"
cat > "$D/rescan.py" <<'PY'
import json, sys
D = "/tmp/dlab-m08-02"
pins = {}
for line in open(D + "/requirements.txt"):
    line = line.strip()
    if "==" in line:
        k, v = line.split("==")
        pins[k.strip()] = v.strip()
fixed = {"requests": "2.32.3", "urllib3": "2.2.0"}
rebuilt = "--rebuilt-base" in sys.argv
rep = json.load(open(D + "/report.json"))
done = []
for f in rep:
    if f["pkg"] in fixed and pins.get(f["pkg"], "") >= fixed[f["pkg"]]:
        f["status"] = "fixed-by-upgrade"
        done.append(f["id"])
    elif f["pkg"] == "openssl" and rebuilt:
        f["status"] = "fixed-by-rebuild"
        done.append(f["id"])
    else:
        f["status"] = "open"
json.dump(rep, open(D + "/report2.json", "w"), indent=1)
print("fixed: %d (%s)" % (len(done), ",".join(sorted(done))))
PY

touch "$D/.ready" && chmod 600 "$D/.ready"
