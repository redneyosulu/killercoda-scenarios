# Worked solution (repo reference, not shown in the UI)

## 1. Plant and detect

```bash
cd /tmp/dlab-m04-03
git init --bare -q remote.git
git init -qb main work 2>/dev/null || { mkdir -p work; git -C work init -q; git -C work checkout -qb main; }
cd work
git remote add origin ../remote.git 2>/dev/null || true
cat > secret-sample.txt <<'EOF'
# FICTIONAL EXAMPLE - not a real credential, never was valid
EXAMPLE_API_KEY=fictional-sample-0000
EOF
git add secret-sample.txt
git commit -qm "add sample config"
git push -qu origin main
git log -S 'fictional-sample-0000' --oneline | tee /tmp/dlab-m04-03/found.txt
git grep 'fictional-sample-0000' $(git rev-list --all) 2>/dev/null | tee -a /tmp/dlab-m04-03/found.txt
```

History search finds the sample even when you pretend not to know it.

## 2. Assess the blast radius

```bash
cd /tmp/dlab-m04-03/work
SHA=$(git log -S 'fictional-sample-0000' --format=%H | head -1)
{
echo "what: EXAMPLE_API_KEY fictional sample in secret-sample.txt, commit $SHA"
echo "where: branch main, no tags, scratch remote received the push"
echo "who: anyone with read access to the scratch remote clone"
} | tee /tmp/dlab-m04-03/impact.txt
git branch -a; git tag; git ls-remote origin | head -3
```

Three lines pin the blast radius: what, where, who.

## 3. Write the response order

```bash
cat > /tmp/dlab-m04-03/order.txt <<'EOF'
1. Revoke the credential with the service owner NOW, before anything else.
2. Remove it from history (filter-repo/purge) and force-push the cleaned branches.
3. Rotate every dependent credential and token that trusted the leaked one.
4. Verify: rescan history, confirm the old value authenticates nowhere.
5. Postmortem: how it leaked, how detection improves, who owns the fix.
Why revoke first: copies already live in clones, caches and backups, so removal alone never kills access.
EOF
cat /tmp/dlab-m04-03/order.txt
```

Revoke first because copies outlive any cleanup; then remove, rotate, verify, learn.
