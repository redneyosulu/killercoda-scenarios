# Worked solution (repo reference, not shown in the UI)

## 1. Plant two faults

```bash
cat myapp.unit app.env
cat > /tmp/dlab-m01-02/faults.txt <<'EOF'
A: app.env sets APP_PORT=eighty (not a number)
B: myapp.unit ExecStart points at myapp-old (missing)
EOF
```

Both faults documented before the first boot attempt.

## 2. Read, do not restart yet

```bash
./boot.sh
cat boot.log
echo "first: fault B, status=203/EXEC, missing binary fires before the bad value" > /tmp/dlab-m01-02/first.txt
```

The missing binary (203/EXEC) fires before the app ever reads the bad value.

## 3. Fix in fault order and verify

```bash
sed -i 's#myapp-old#myapp#' /tmp/dlab-m01-02/myapp.unit
/tmp/dlab-m01-02/boot.sh
sed -i 's#eighty#18082#' /tmp/dlab-m01-02/app.env
/tmp/dlab-m01-02/boot.sh
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:18082/
```

Faults fixed in firing order; final boot answers HTTP 200.
