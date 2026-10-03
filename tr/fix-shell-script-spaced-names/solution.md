# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Take the broken script

```bash
cd /tmp/dlab-m03-01 && ./broken.sh
./broken.sh 2>&1 | tee /tmp/dlab-m03-01/breakage.txt
ls /tmp/dlab-m03-01/out-broken >> /tmp/dlab-m03-01/breakage.txt
```

Kelime bölme boşluklu ismi parçalar; tireli isim bayrağa dönüşür.

## 2. Repair for adversarial names

```bash
cat > /tmp/dlab-m03-01/fixed.sh <<'EOF'
#!/bin/bash
set -euo pipefail
src="/tmp/dlab-m03-01/files"
dest="/tmp/dlab-m03-01/out"
mkdir -p -- "$dest"
n=0
for f in "$src"/*; do
  cp -- "$f" "$dest/"
  n=$((n+1))
done
echo "copied $n files"
EOF
chmod +x /tmp/dlab-m03-01/fixed.sh
shellcheck -S warning /tmp/dlab-m03-01/fixed.sh
```

Glob artı tırnak artı koruma; shellcheck temiz.

## 3. Test both outcomes

```bash
cat > /tmp/dlab-m03-01/test.sh <<'EOF'
#!/bin/bash
set -euo pipefail
D=/tmp/dlab-m03-01
rm -rf "$D/out" "$D/out-broken"; mkdir -p "$D/out" "$D/out-broken"
bash "$D/broken.sh" >/dev/null 2>&1 || true
[ "$(ls "$D/out-broken" | wc -l)" = "3" ] && { echo "broken unexpectedly correct"; exit 1; }
echo "broken fails as expected"
bash "$D/fixed.sh"
for n in 'Q3 report (final).txt' '-leading-dash.log' 'normal.txt'; do
  [ -f "$D/out/$n" ] || { echo "missing $n"; exit 1; }
done
echo ALL-TESTS-PASS
EOF
chmod +x /tmp/dlab-m03-01/test.sh
/tmp/dlab-m03-01/test.sh
```

Test bozuk betiği mahkum eder, onarımı aklamış olur.
