# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Build the broken scene

```bash
runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf 2>/tmp/dlab-m01-01/denial.log
cat /tmp/dlab-m01-01/denial.log
```

Okuma svc için başarısız olur, root için çalışır: dosya 600 root:root durumdadır.

## 2. Diagnose before repair

```bash
cat > /tmp/dlab-m01-01/diagnosis.txt <<'EOF'
reader: svc
owner: root
column: group (svc is in appread)
repair: chgrp appread app.conf + chmod 640
why: keeps root ownership, grants the service group read only
EOF
```

Okuyan svc, sahip root; grup sütunu karar verir; chgrp+640 root sahipliğini koruyup en dar yetkiyi verir.

## 3. Repair narrowly and verify

```bash
chgrp appread /tmp/dlab-m01-01/app.conf
chmod 640 /tmp/dlab-m01-01/app.conf
runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf
ls -l /tmp/dlab-m01-01/
```

Grup onarımı uygulandı; svc okuyabiliyor; modlar dar kaldı.
