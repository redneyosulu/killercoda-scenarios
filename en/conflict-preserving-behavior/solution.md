# Worked solution (repo reference, not shown in the UI)

## 1. Stage the collision

```bash
cd /tmp/dlab-m04-01/repo
git init -b main -q 2>/dev/null || git init -q
echo TIMEOUT=20 > app.conf
git add app.conf
git commit -qm "base: TIMEOUT=20 default"
git branch tune
echo TIMEOUT=30 > app.conf
git commit -qam "main: TIMEOUT=30, slow dependency needs headroom"
git checkout -q tune
echo TIMEOUT=10 > app.conf
git commit -qam "tune: TIMEOUT=10, incident review demands fast timeout"
git merge main || true
grep -c '<<<<<<<' app.conf
```

Two commits from one base collide on the same line: the markers are the proof.

## 2. Test first, then resolve

```bash
cat > /tmp/dlab-m04-01/repo/check.sh <<'EOF'
#!/bin/bash
F=/tmp/dlab-m04-01/repo/app.conf
grep -q '<<<<<<<' "$F" && { echo "markers remain"; exit 1; }
grep -q '30' "$F" || { echo "slow-dependency value 30 lost"; exit 1; }
grep -q '10' "$F" || { echo "incident-review value 10 lost"; exit 1; }
echo COMBINED-OK
EOF
chmod +x /tmp/dlab-m04-01/repo/check.sh
cd /tmp/dlab-m04-01/repo
./check.sh || true
cat > app.conf <<'EOF'
TIMEOUT_PROD=30
TIMEOUT_REVIEW=10
EOF
./check.sh
```

The check convicts the marked file, then clears the combined resolution.

## 3. Commit the reasoning

```bash
cd /tmp/dlab-m04-01/repo
git add app.conf
git commit -m "merge tune: keep TIMEOUT_PROD=30 for the slow dependency and TIMEOUT_REVIEW=10 from the incident review; per-env values serve both" | tee /tmp/dlab-m04-01/commit-out.txt
git log --oneline --graph -5
./check.sh
```

One merge commit records both reasons; the graph proves the join.
