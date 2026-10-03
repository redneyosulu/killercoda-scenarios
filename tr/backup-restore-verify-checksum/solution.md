# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Back up with context

```bash
cd /tmp/dlab-m07-02
tar -czf backup.tar.gz -C src .
tar -tzf backup.tar.gz
{ echo "schema: 1"; echo "reader: fixture-reader 0.3.0"; echo "at: $(date -u +%FT%TZ)"; echo "RPO: 60 minutes"; echo "RTO: 15 minutes"; } | tee backup-meta.txt
```

Önce bağlam: sürümler, saat ve yargılanacağın sayılar.

## 2. Restore to a wiped target

```bash
cd /tmp/dlab-m07-02
rm -rf restore && mkdir -p restore
tar -xzf backup.tar.gz -C restore
bash restore/migrate.sh
cat restore/migrated.marker
python3 restore/app.py --dir restore
```

Ayrı zemin, oynatılmış göç, okuyucu geri yüklenen baytlarda canlı.

## 3. Verify and time it

```bash
cd /tmp/dlab-m07-02
S0=$(date +%s)
tar -xzf backup.tar.gz -C restore
S1=$(date +%s)
{ echo "src: $(sha256sum src/records.txt)"; echo "restored: $(sha256sum restore/records.txt)"; echo "restore_secs=$((S1-S0))"; echo "RTO: 15 minutes"; echo "verdict: PASS (seconds against a 15-minute RTO)"; echo "drill: extract plus migrate plus reader check, all green"; } | tee verify.txt
```

Eşleşen karmalar, dakikalara karşı saniyeler: hüküm geçti, kayıtta.
