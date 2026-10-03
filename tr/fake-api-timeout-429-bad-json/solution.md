# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Build the misbehaving API

```bash
B=http://127.0.0.1:18084
curl -s -o /dev/null -w 'ok:%{http_code}\n' $B/ok | tee /tmp/dlab-m03-03/endpoints.txt
curl -s -m 3 -o /dev/null -w 'slow:%{http_code}\n' $B/slow | tee -a /tmp/dlab-m03-03/endpoints.txt
curl -s -o /dev/null -w 'limited1:%{http_code}\n' $B/limited | tee -a /tmp/dlab-m03-03/endpoints.txt
curl -s -o /dev/null -w 'limited2:%{http_code}\n' $B/limited | tee -a /tmp/dlab-m03-03/endpoints.txt
curl -s -o /dev/null -w 'broken:%{http_code}\n' $B/broken | tee -a /tmp/dlab-m03-03/endpoints.txt
```

Dört yerel uç nokta, dış trafik yok.

## 2. Write the hardened client

```bash
cat > /tmp/dlab-m03-03/fetch.sh <<'EOF'
#!/bin/bash
BASE=http://127.0.0.1:18084
TIMEOUT=8
MAX_ATTEMPTS=3
BACKOFF=2
path=${1:?usage: fetch.sh PATH}
attempt=1
while [ $attempt -le $MAX_ATTEMPTS ]; do
  hdr=$(mktemp); body=$(mktemp)
  code=$(curl -s -m $TIMEOUT -D "$hdr" -o "$body" -w '%{http_code}' "$BASE$path") || code=000
  if [ "$code" = "429" ]; then
    wait=$(grep -i '^retry-after:' "$hdr" | awk '{print $2}' | tr -d '\r')
    sleep "${wait:-$BACKOFF}"
  elif [ "$code" = "200" ]; then
    if jq -e . "$body" >/dev/null 2>&1; then cat "$body"; rm -f "$hdr" "$body"; exit 0
    else rm -f "$hdr" "$body"; echo "bad json" >&2; exit 2; fi
  fi
  rm -f "$hdr" "$body"
  attempt=$((attempt+1)); sleep $BACKOFF
done
echo "failed after $MAX_ATTEMPTS" >&2; exit 1
EOF
chmod +x /tmp/dlab-m03-03/fetch.sh
/tmp/dlab-m03-03/fetch.sh /ok
```

Bütçe görünür, 429 saygılı, JSON ayrıştırılmış, hatalar temiz.

## 3. Test the bad inputs

```bash
F=/tmp/dlab-m03-03/fetch.sh
curl -s http://127.0.0.1:18084/reset >/dev/null
START=$(date +%s); $F /slow >/dev/null 2>&1; SLOW_EXIT=$?; SLOW_DT=$(( $(date +%s) - START ))
$F /limited > /tmp/dlab-m03-03/limited-out.txt 2>&1; LIM_EXIT=$?
$F /broken >/dev/null 2>&1; BROKEN_EXIT=$?
printf 'slow: exit=%s secs=%s\nlimited: exit=%s hits=%s\nbroken: exit=%s\n' "$SLOW_EXIT" "$SLOW_DT" "$LIM_EXIT" "$(wc -l < /tmp/dlab-m03-03/hits.log)" "$BROKEN_EXIT" | tee /tmp/dlab-m03-03/suite.txt
```

Sınırlı yavaş, tekrarlı-ama-yüklenilmemiş limited, temiz bozuk.
