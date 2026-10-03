# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Plant two faults

```bash
cat myapp.unit app.env
cat > /tmp/dlab-m01-02/faults.txt <<'EOF'
A: app.env sets APP_PORT=eighty (not a number)
B: myapp.unit ExecStart points at myapp-old (missing)
EOF
```

İlk başlatma denemesinden önce iki hata da belgelendi.

## 2. Read, do not restart yet

```bash
./boot.sh
cat boot.log
echo "first: fault B, status=203/EXEC, missing binary fires before the bad value" > /tmp/dlab-m01-02/first.txt
```

Kayıp ikili (203/EXEC) hatalı değer okunmadan önce patlar.

## 3. Fix in fault order and verify

```bash
sed -i 's#myapp-old#myapp#' /tmp/dlab-m01-02/myapp.unit
/tmp/dlab-m01-02/boot.sh
sed -i 's#eighty#18082#' /tmp/dlab-m01-02/app.env
/tmp/dlab-m01-02/boot.sh
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:18082/
```

Hatalar patlama sırasıyla düzeltildi; son başlatma HTTP 200 döndürüyor.
