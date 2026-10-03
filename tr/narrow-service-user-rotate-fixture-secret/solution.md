# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Map the excess reach

```bash
cd /tmp/dlab-m08-01
{ echo "job: run job.sh daily, needs read job/ plus write result.txt, needs the narrow secret only"; echo "reach-now: read job/ secret/ other/ (world-readable), write other/"; echo "excess-1: read secret/old.key enables credential theft on any svc compromise"; echo "excess-2: write other/ enables disk-fill and dropper staging"; echo "remove: secret/ read, other/ write"; } | tee reach-map.txt
runuser -u svc -- cat secret/old.key | head -1
```

İki hibe, iki hırsızlık hikayesi: harita neyin gideceğini adlandırır.

## 2. Narrow and rotate

```bash
cd /tmp/dlab-m08-01
sed -i 's/fixture-old-0000/fixture-new-0001/' job/secret.key
echo "rotate: narrow channel now holds fixture-new-0001" | tee rotate-log.txt
echo "audit: old value lives in secret/old.key (wide channel)" | tee -a rotate-log.txt
grep -r "fixture-old-0000" job secret other 2>/dev/null | tee -a rotate-log.txt || true
shred -u secret/old.key; rmdir secret 2>/dev/null || rm -f secret/old.key
echo "purge: wide-channel copy shredded" | tee -a rotate-log.txt
chown -R root:svc job && chmod 750 job && chmod 640 job/secret.key job/job.sh
touch job/result.txt && chown svc:svc job/result.txt && chmod 640 job/result.txt
chmod 755 other && rm -f other/note.txt
grep -rq "fixture-old-0000" job secret other 2>/dev/null && echo "audit-dirty" | tee -a rotate-log.txt || echo "audit-clean: old value gone from live paths" | tee -a rotate-log.txt
echo "prevent: 750/640 perms, no plaintext outside narrow channel, rotation calendar set" | tee -a rotate-log.txt
ls -l job
```

Döndür, denetle, temizle, önle: bu sırayla, kayıtta.

## 3. Prove both directions

```bash
cd /tmp/dlab-m08-01
runuser -u svc -- bash job/job.sh && echo "exit: 0" | tee job-proof.txt
cat job/result.txt | tee -a job-proof.txt
runuser -u svc -- cat secret/old.key 2>&1 | tee deny-proof.txt || true
runuser -u svc -- bash -c 'echo x > other/evil.txt' 2>&1 | tee -a deny-proof.txt || true
```

Çitin içinde yeşil, dışında ret: iki yön de kanıtlı.
