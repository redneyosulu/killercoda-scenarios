# Worked solution (repo reference, not shown in the UI)

## 1. Build the broken scene

```bash
runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf 2>/tmp/dlab-m01-01/denial.log
cat /tmp/dlab-m01-01/denial.log
```

The read fails for svc while root reads fine: the file is 600 root:root.

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

Reader svc, owner root; the group column decides; chgrp+640 keeps root ownership with least privilege.

## 3. Repair narrowly and verify

```bash
chgrp appread /tmp/dlab-m01-01/app.conf
chmod 640 /tmp/dlab-m01-01/app.conf
runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf
ls -l /tmp/dlab-m01-01/
```

Group repair applied; svc reads fine; modes stay narrow.
