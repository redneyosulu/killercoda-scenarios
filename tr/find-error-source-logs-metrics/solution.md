# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Read the graph first

```bash
cd /tmp/dlab-m07-01
head -5 metrics.csv
awk -F, '$2=="checkout" && $4>10 {print "spike minute "$1" errors "$4; exit}' metrics.csv
{ echo "endpoint: /checkout"; echo "start: minute 10"; echo "share: 100 of 400 per minute = 25%"; } | tee scope.txt
```

Önce grafik konuşur: ödeme, 10. dakika, trafiğin çeyreği.

## 2. Join to the lines

```bash
cd /tmp/dlab-m07-01
grep -o '"req": "req-1[0-9]-[0-9]*"' app.log | head -3
RID=$(grep -o 'req-1[0-9]-[0-9]*' app.log | head -1)
grep "$RID" app.log | tee join.txt
grep -h "downstream" app.log | grep -o 'inventory: timeout after [0-9]*ms' | sort | uniq -c | tee -a join.txt
```

Tek istek kimliği grafikle logu köprüler; her satır envanteri suçlar.

## 3. Name the cause, not the symptom

```bash
cat > /tmp/dlab-m07-01/diagnosis.txt <<'EOF'
symptom: checkout 500s at 40% for minutes 10-19 (metrics.csv, app.log status 500)
cause: inventory downstream timeout after 2000ms on every spike-window checkout (app.log downstream field)
fix-direction: toward inventory (raise timeout, add retry with backoff, or circuit-break), not toward checkout code
EOF
cat /tmp/dlab-m07-01/diagnosis.txt
```

Ödeme acır, envanter kanar: düzeltme kanıtın gösterdiği yerdedir.
