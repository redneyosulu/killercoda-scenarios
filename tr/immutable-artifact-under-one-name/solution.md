# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Stage the incident

```bash
cd /tmp/dlab-m06-02
docker build -q -t m06v:0.1.0 app/ >/dev/null
D1=$(docker inspect --format '{{.Id}}' m06v:0.1.0)
echo "build two" > app/version.txt
docker build -q -t m06v:0.1.0 app/ >/dev/null
D2=$(docker inspect --format '{{.Id}}' m06v:0.1.0)
{ echo "tag: m06v:0.1.0"; echo "certified: $D1"; echo "would-ship: $D2"; echo "note: the name stood still while the bytes moved; 0.1.0 no longer names what was certified."; } | tee incident.txt
[ "$D1" != "$D2" ] && echo INCIDENT-REPRODUCED
```

Aynı ad, farklı baytlar: istenince olan hareketli etiket olayı.

## 2. Freeze the names

```bash
cd /tmp/dlab-m06-02
cat > guard.sh <<'EOF'
#!/bin/bash
DB=/tmp/dlab-m06-02/tags.db
touch "$DB"
if [ "$1" = "push" ]; then
  old=$(grep "^$2:" "$DB" 2>/dev/null | cut -d: -f2-)
  if [ -n "$old" ] && [ "$old" != "$3" ]; then
    echo "IMMUTABLE-DENIED: tag $2 already points at $old" >&2; exit 1
  fi
  grep -v "^$2:" "$DB" > "$DB.tmp" 2>/dev/null || true
  echo "$2:$3" >> "$DB.tmp"; mv "$DB.tmp" "$DB"
  echo "RECORDED $2 -> $3"
fi
EOF
chmod +x guard.sh
CUR=$(docker inspect --format '{{.Id}}' m06v:0.1.0)
./guard.sh push 0.1.0 "$CUR"
./guard.sh push 0.1.0 sha256:deadbeef 2>&1 | tee freeze.log || true
echo "build three" > app/version.txt
docker build -q -t m06v:0.1.1 app/ >/dev/null
NEW=$(docker inspect --format '{{.Id}}' m06v:0.1.1)
./guard.sh push 0.1.1 "$NEW"
docker tag "$NEW" m06v:staging
docker tag "$NEW" m06v:prod
{ echo "0.1.1: $NEW"; echo "staging: $(docker inspect --format '{{.Id}}' m06v:staging)"; echo "prod: $(docker inspect --format '{{.Id}}' m06v:prod)"; } | tee promote.txt
```

Defter dondu, üstüne yazma geri tepti, yükseltme özete sabitlendi.

## 3. Prove identical bytes

```bash
cd /tmp/dlab-m06-02
ID=$(docker inspect --format '{{.Id}}' m06v:0.1.1)
{ echo "env-a: $ID"; echo -n "smoke-a: "; docker run --rm "$ID"; } | tee pulls.txt
{ echo "env-b: $ID"; echo -n "smoke-b: "; docker run --rm "$ID"; } | tee -a pulls.txt
```

İki ortam, tek özet, eşleşen duman.
