# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Break state and network

```bash
DC="docker compose"
cd /tmp/dlab-m05-02
cat > compose-broken.yaml <<'EOF'
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: fixture-pw-0000  # FICTIONAL fixture password
      POSTGRES_DB: appdb
    networks: [dbnet]
  app:
    build: ./app
    environment:
      DATABASE_URL: postgresql://app:fixture-pw-0000@db:5432/appdb
    ports: ["18086:18086"]
    networks: [appnet]
    depends_on: [db]
networks:
  appnet: {}
  dbnet: {}
EOF
$DC -f compose-broken.yaml up -d --build >broken-up.log 2>&1 || true
sleep 25
$DC -f compose-broken.yaml logs app 2>&1 | tee failure.txt
grep -i "could not translate host name" failure.txt
```

Bölünmüş ağlar ismi bozar; log DNS hatasını alıntılar.

## 2. Fix both layers

```bash
DC="docker compose"
cd /tmp/dlab-m05-02
$DC -f compose-broken.yaml down -v >/dev/null 2>&1 || true
cat > compose.yaml <<'EOF'
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: app
      POSTGRES_PASSWORD: fixture-pw-0000  # FICTIONAL fixture password
      POSTGRES_DB: appdb
    volumes: ["pgdata:/var/lib/postgresql/data"]
    networks: [appnet]
  app:
    build: ./app
    environment:
      DATABASE_URL: postgresql://app:fixture-pw-0000@db:5432/appdb
    ports: ["18086:18086"]
    networks: [appnet]
    depends_on: [db]
networks:
  appnet: {}
volumes:
  pgdata: {}
EOF
$DC up -d --build >fixed-up.log 2>&1
for i in $(seq 1 45); do curl -sf "http://127.0.0.1:18086/" >/dev/null 2>&1 && break; sleep 2; done
curl -s "http://127.0.0.1:18086/"; echo
$DC ps
```

Paylaşılan ağ artı adlandırılmış birim: isimler çözülür, verinin evi olur.

## 3. Prove it survives

```bash
DC="docker compose"
cd /tmp/dlab-m05-02
curl -s "http://127.0.0.1:18086/put?k=stay&v=here"
$DC rm -sf db
$DC up -d db
for i in $(seq 1 45); do curl -sf "http://127.0.0.1:18086/" >/dev/null 2>&1 && break; sleep 2; done
curl -s "http://127.0.0.1:18086/get?k=stay" | tee proof.txt
APPC=$(docker ps --format '{{.Names}}' | grep -i "app" | head -1)
docker exec "$APPC" getent hosts db | tee -a proof.txt
docker volume ls | grep pgdata | tee -a proof.txt
```

Satır veritabanı konteynerinden uzun yaşar; isim hâlâ çözülür.
