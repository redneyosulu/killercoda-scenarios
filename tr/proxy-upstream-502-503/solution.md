# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Build the pair

```bash
curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:18080/ | tee /tmp/dlab-m02-02/healthy.txt
printf '/tmp/dlab-m02-02/proxy.log\n/tmp/dlab-m02-02/upstream.log\n' > /tmp/dlab-m02-02/logs.txt
```

Başlangıç 200 cevabı iki log konumuyla kaydedildi.

## 2. Break it twice, read both sides

```bash
kill $(cat /tmp/dlab-m02-02/upstream.pid)
 START=$(date +%s); curl -s -o /dev/null -w '%{http_code} in %{time_total}s\n' http://127.0.0.1:18080/ | tee /tmp/dlab-m02-02/case502.log
UPSTREAM_LOG=/tmp/dlab-m02-02/upstream.log UPSTREAM_MODE=fail503 nohup python3 /tmp/dlab-m02-02/upstream.py 18081 >/tmp/dlab-m02-02/up.log 2>&1 &
echo $! > /tmp/dlab-m02-02/upstream.pid
sleep 1
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:18080/ | tee /tmp/dlab-m02-02/case503.log
grep -- '-> 502' /tmp/dlab-m02-02/proxy.log | tail -1
grep -- '-> 503' /tmp/dlab-m02-02/proxy.log | tail -1
```

Upstream işi olmadan hızlı 502; iki tarafta eşleşen satırlarla 503.

## 3. Fix upstream only

```bash
kill $(cat /tmp/dlab-m02-02/upstream.pid) 2>/dev/null
UPSTREAM_LOG=/tmp/dlab-m02-02/upstream.log nohup python3 /tmp/dlab-m02-02/upstream.py 18081 >/tmp/dlab-m02-02/up.log 2>&1 &
echo $! > /tmp/dlab-m02-02/upstream.pid
sleep 1
curl -s -o /dev/null -w '%{http_code}\n' http://127.0.0.1:18080/
ss -tlnp | grep -E ':(18080|18081) '
sha256sum -c <(awk '{print $1"  /tmp/dlab-m02-02/proxy.py"}' /tmp/dlab-m02-02/proxy.sha)
```

Upstream iyileşti, 200 ler geri geldi, port başına tek dinleyici, proxy yapılandırması el değmemiş.
