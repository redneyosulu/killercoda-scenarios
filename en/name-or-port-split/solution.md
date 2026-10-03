# Worked solution (repo reference, not shown in the UI)

## 1. Plant both faults

```bash
printf 'fault1: svc-lab.test pinned to 127.0.0.2 (wrong)\nfault2: client aims at 19090 (wrong, app is on 18080)\n' > /tmp/dlab-m02-01/faults.txt
curl -m 3 -v http://svc-lab.test:19090/ 2>&1 | tail -2
```

Both faults documented before any fix; the request fails.

## 2. Split name from port

```bash
getent hosts svc-lab.test
python3 -c "import socket; print(socket.gethostbyname('svc-lab.test'))"
curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:18080/ | tee /tmp/dlab-m02-01/direct.txt
echo 'guilty layer: NAME (pin points at 127.0.0.2); port is fine when aimed directly' > /tmp/dlab-m02-01/split.txt
```

Resolver tools disagree (hosts pin vs real), direct port test returns 200: the name layer is guilty.

## 3. Repair in layer order

```bash
grep -v 'svc-lab.test' /etc/hosts > /tmp/hosts.new
echo '127.0.0.1 svc-lab.test' >> /tmp/hosts.new
cat /tmp/hosts.new > /etc/hosts
getent hosts svc-lab.test
python3 -c "import socket; print(socket.gethostbyname('svc-lab.test'))"
curl -s -o /dev/null -w '%{http_code}\n' http://svc-lab.test:18080/
```

Name layer fixed first, then one clean request proves the port.
