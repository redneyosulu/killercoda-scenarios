#!/bin/bash
D=/tmp/dlab-m02-03
mkdir -p "$D"
export DEBIAN_FRONTEND=noninteractive
pkg_for() { case "$1" in curl) echo curl;; ss) echo iproute2;; pkill|pgrep) echo procps;; openssl) echo openssl;; git) echo git;; python3) echo python3;; runuser) echo login;; nc) echo netcat-openbsd;; find) echo findutils;; *) echo "$1";; esac; }
miss=""
for t in curl ss pkill openssl git python3 runuser find nc; do command -v "$t" >/dev/null 2>&1 || miss="$miss $(pkg_for $t)"; done
if [ -n "$miss" ]; then apt-get update -qq && apt-get install -y -qq $miss; fi
printf 'TEST ONLY - fixture CA, never trust\n' > "$D/TEST-ONLY.txt"
openssl req -x509 -newkey rsa:2048 -nodes -keyout "$D/test-root.key" -out "$D/test-root.crt" -days 30 -subj "/CN=TEST-ONLY lab root" 2>/dev/null
openssl req -newkey rsa:2048 -nodes -keyout "$D/test-int.key" -out "$D/test-int.csr" -subj "/CN=TEST-ONLY lab intermediate" 2>/dev/null
printf 'basicConstraints=critical,CA:true\nkeyUsage=critical,keyCertSign,cRLSign\n' > "$D/int.ext"
openssl x509 -req -in "$D/test-int.csr" -CA "$D/test-root.crt" -CAkey "$D/test-root.key" -CAcreateserial -days 30 -extfile "$D/int.ext" -out "$D/test-int.crt" 2>/dev/null
cp "$D/test-root.crt" "$D/test-ca.crt"
cat "$D/test-root.crt" "$D/test-int.crt" > "$D/test-ca-full.crt"
for spec in "good:svc-lab.test" "wrong:wrong-name.test"; do
  name=${spec%%:*}; san=${spec##*:}
  openssl req -newkey rsa:2048 -nodes -keyout "$D/leaf-$name.key" -out "$D/leaf-$name.csr" -subj "/CN=$san" 2>/dev/null
  printf 'basicConstraints=CA:false\nkeyUsage=digitalSignature,keyEncipherment\nextendedKeyUsage=serverAuth\nsubjectAltName=DNS:%s\n' "$san" > "$D/leaf-$name.ext"
  openssl x509 -req -in "$D/leaf-$name.csr" -CA "$D/test-int.crt" -CAkey "$D/test-int.key" -CAcreateserial -days 30 -extfile "$D/leaf-$name.ext" -out "$D/leaf-$name.crt" 2>/dev/null
done
ls /tmp > "$D/tmp-before.txt"
touch "$D/.ready" && chmod 600 "$D/.ready"
