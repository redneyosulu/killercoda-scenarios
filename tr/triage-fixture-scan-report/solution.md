# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Rank by real risk

```bash
cd /tmp/dlab-m08-02
python3 -c "import json; print(len(json.load(open('report.json'))), 'findings')"
{ echo "F001 requests critical: reachable + public PoC + credential leak -> SPRINT"; echo "F002 urllib3 high: reachable + public PoC + smuggling -> SPRINT"; echo "F003 openssl high: reachable + known CVE + tls decrypt -> SPRINT (rebuild)"; echo "noise: unreachable medium/low without exploit stay out of the sprint (list in file, reasons attached)"; echo "notice: F060 kernel-note is unfixable here, monitor only"; } | tee triage.md
```

Üçü dönemi hak eder; kalanı gerekçe hak eder.

## 2. Fix what works

```bash
cd /tmp/dlab-m08-02
printf 'requests==2.32.3\nurllib3==2.2.0\n' > requirements.txt
python3 rescan.py --rebuilt-base | tee fixed.txt
python3 -c "import json; r=json.load(open('report2.json')); print([f['id'] for f in r if f.get('status','').startswith('fixed')])" 
```

Yükselt, yeniden derle, tekrar tara: ilk üç gerçekten kapanır.

## 3. Accept the rest properly

```bash
cd /tmp/dlab-m08-02
{ echo "accept: unreachable mediums, owner learner, expires 2027-03-01, rescan on expiry"; echo "accept: dev-only lows, owner learner, expires 2027-03-01, never ships to prod"; echo "note: F060 kernel-note unfixable in this scope, monitor vendor feed"; } | tee accepts.md
ls triage.md fixed.txt accepts.md report2.json
```

Kabul demek tarihli, sahipli ve yeniden kontrollü demektir; yoksa kabul değildir.
