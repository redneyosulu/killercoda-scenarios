# Worked solution (repo reference, not shown in the UI)

## 1. Publish the mistake

```bash
cd /tmp/dlab-m04-02
git init --bare -q remote.git
git clone -q remote.git author 2>/dev/null
git clone -q remote.git teammate 2>/dev/null
cd author
git checkout -qb main 2>/dev/null || git checkout -b main
echo "MAX_RETRIES=9999  # BAD DEFAULT, do not ship" > settings.conf
git add settings.conf
git commit -qm "feat: raise retries to 9999"
git push -qu origin main
cd ../teammate
git pull -q origin main 2>/dev/null || git checkout -qb main origin/main
git log --oneline -2
```

Both clones now hold the bad commit: the mistake is published.

## 2. Revert and converge

```bash
cd /tmp/dlab-m04-02/author
git revert --no-edit HEAD
git push origin main
cd ../teammate
git pull origin main
echo "--- author:"; git log --oneline -3
echo "--- teammate:"; git log --oneline -3
git status -sb | head -1
```

History gains a revert; both sides converge with plain pulls.

## 3. Show the forbidden alternative

```bash
cd /tmp/dlab-m04-02/author
git reset --hard -q HEAD~1
git push --force -q origin main
cd ../teammate
git fetch -q origin
{ git status -sb; git pull origin main 2>&1 || true; } | tee /tmp/dlab-m04-02/divergence.txt
cd /tmp/dlab-m04-02
rm -rf author teammate remote.git
echo "Never rewrite a shared branch: reset plus force-push strands teammates, so revert published mistakes instead." > rule.txt
cat rule.txt
```

Force-push strands the teammate; the rule fits in one sentence.
