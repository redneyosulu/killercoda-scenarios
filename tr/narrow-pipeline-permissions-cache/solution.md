# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Map the excess

```bash
cat > /tmp/dlab-m06-03/scopes.yaml <<'EOF'
status-job:
  granted: fixture-full-0000   # status plus deploy (too wide)
  needed: [status]
  narrowed-to: fixture-status-0001
deploy-job:
  granted: fixture-full-0000
  needed: [deploy]
EOF
{ echo "narrowed: status-job from fixture-full-0000 to fixture-status-0001"; echo "reason: status updates need only the status API; deploy scope removed"; } | tee /tmp/dlab-m06-03/narrow.txt
curl -s -H "Authorization: Bearer fixture-status-0001" http://127.0.0.1:18089/status
```

Durum işi tek kapsam tutar; dağıtım jetonu dışarıda kalır.

## 2. Repair the cache key

```bash
cd /tmp/dlab-m06-03
LOCK=$(sha256sum deps.lock | cut -c1-8)
cp cache/deps-main.marker feature/restored.marker
{ echo "blind-key: deps-shared"; echo "mix: $(cat feature/restored.marker) leaked into feature/"; } | tee cache-proof.txt
rm -f feature/restored.marker
KEY="deps-feature-$LOCK"
if [ -f "cache/$KEY.marker" ]; then cp "cache/$KEY.marker" feature/restored.marker; echo "HIT $KEY" | tee -a cache-proof.txt
else echo "MISS $KEY: no foreign bytes restored, fresh install instead (fail closed)" | tee -a cache-proof.txt; fi
echo "$KEY" | tee -a cache-proof.txt
```

Kör anahtarlar dalları karıştırır; çitli anahtarlar yüksek sesle ıskalar.

## 3. Prove the denial

```bash
cd /tmp/dlab-m06-03
curl -s -o /dev/null -w 'deploy-with-narrow:%{http_code}\n' -X POST -H "Authorization: Bearer fixture-status-0001" http://127.0.0.1:18089/deploy | tee deny.txt
LOCK=$(sha256sum deps.lock | cut -c1-8)
{ echo "key: deps-feature-$LOCK"; echo -n "status-with-narrow: "; curl -s -H "Authorization: Bearer fixture-status-0001" http://127.0.0.1:18089/status; echo "GREEN-WITH-REPAIRED-CACHE"; } | tee green-run.log
```

Kaldırılan erişim geri teper; tutulan erişim yeşil kalır.
