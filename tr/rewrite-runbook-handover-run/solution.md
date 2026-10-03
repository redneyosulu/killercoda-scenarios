# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Rewrite to the standard

```bash
cat > /tmp/dlab-m07-03/RUNBOOK.md <<'EOF'
# Disk-pressure runbook v2
Trigger: alert DATA-PRESSURE or verify-incident.sh prints anything but DONE-CONDITION-PASS.
Preconditions: ssh to the fixture host; /tmp/dlab-m07-03 present; no deploy running.
Steps:
1. `./verify-incident.sh` -> expect PRESENT junk.cache or TOO-BIG app.log.
2. `rm data/junk.cache` -> expect no output; `ls data` must not list junk.cache.
3. `: > data/app.log` (or provided rotate) -> expect `stat -c %s data/app.log` under 1000000.
4. Re-run `./verify-incident.sh` -> expect DONE-CONDITION-PASS.
Decision points: if app.log regrows within 5 minutes, escalate to the owning team instead of repeating.
Done condition: verify-incident.sh prints DONE-CONDITION-PASS.
Stop conditions: stop and escalate if any command errors, if data/ holds anything besides junk.cache and app.log, or after 15 minutes without PASS.
EOF
cd /tmp/dlab-m07-03 && git add RUNBOOK.md && git commit -qm "runbook v2: stranger standard" && git log --oneline -2
```

Altı öğe, telepati gerekmez.

## 2. Hand over and watch

```bash
cd /tmp/dlab-m07-03
./verify-incident.sh | tee handover.txt
{ echo "TRIP-1: step 1 output PRESENT junk.cache but runbook did not say which line means go; FIX: trigger line now quotes the exact FAIL strings"; echo "TRIP-2: rotate command missing, I reached for rm on app.log; FIX: step 3 now names truncate as the only allowed write"; } | tee -a handover.txt
```

Yabancı sensin, beş dakika sonraki: her takılma bir belge arızasıdır.

## 3. Run it and log it

```bash
cd /tmp/dlab-m07-03
rm -f data/junk.cache
: > data/app.log
./verify-incident.sh | tee run-proof.txt
cat > changelog.txt <<'EOF'
who: on-call learner
what: removed data/junk.cache, truncated data/app.log per RUNBOOK.md v2
when: drill run, UTC stamped in git log
why: DATA-PRESSURE fixture; done condition now PASS
reversal: restore junk.cache from backup.tar.gz equivalent; logs are append-only, nothing to undelete
EOF
git add -A && git commit -qm "run repaired procedure, changelog entry" && cat changelog.txt
```

Bitti demek kanıtlı demek; değişiklik günlüğü senin yerine hatırlar.
