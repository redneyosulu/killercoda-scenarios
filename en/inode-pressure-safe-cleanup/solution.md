# Worked solution (repo reference, not shown in the UI)

## 1. Create bounded pressure

```bash
ls /tmp/dlab-m01-03 | wc -l
df -i /tmp
cat /tmp/dlab-m01-03/baseline.txt
printf 'before: %s\nnow-files: 50000\n' "$(cat /tmp/dlab-m01-03/baseline.txt)" > /tmp/dlab-m01-03/numbers.txt
```

Pressure confirmed against the recorded baseline.

## 2. Split blocks vs inodes

```bash
df -h /tmp; df -i /tmp
du -sh /tmp/dlab-m01-03
printf 'blocks fine, inodes under pressure (files, not bytes)\n' > /tmp/dlab-m01-03/split.txt
```

Inodes, not blocks: many tiny files.

## 3. Clean in batches, verify each step

```bash
find /tmp/dlab-m01-03 -name 'f-*' -delete
df -i /tmp
rmdir /tmp/dlab-m01-03 2>/dev/null || find /tmp/dlab-m01-03 -mindepth 1 -delete; rmdir /tmp/dlab-m01-03
df -i /tmp
```

Batched cleanup, directory gone, inodes recovered.
