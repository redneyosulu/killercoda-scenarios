# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Create bounded pressure

```bash
ls /tmp/dlab-m01-03 | wc -l
df -i /tmp
cat /tmp/dlab-m01-03/baseline.txt
printf 'before: %s\nnow-files: 50000\n' "$(cat /tmp/dlab-m01-03/baseline.txt)" > /tmp/dlab-m01-03/numbers.txt
```

Baskı kaydedilen başlangıç değerine karşı doğrulandı.

## 2. Split blocks vs inodes

```bash
df -h /tmp; df -i /tmp
du -sh /tmp/dlab-m01-03
printf 'blocks fine, inodes under pressure (files, not bytes)\n' > /tmp/dlab-m01-03/split.txt
```

Bloklar değil, inode lar: bir sürü minik dosya.

## 3. Clean in batches, verify each step

```bash
find /tmp/dlab-m01-03 -name 'f-*' -delete
df -i /tmp
rmdir /tmp/dlab-m01-03 2>/dev/null || find /tmp/dlab-m01-03 -mindepth 1 -delete; rmdir /tmp/dlab-m01-03
df -i /tmp
```

Öbekli temizlik, dizin gitti, inode lar geri geldi.
