# Worked solution (repo reference, not shown in the UI)

## 1. Decide with the checklist

```bash
cat > /tmp/dlab-m08-03/checklist.md <<'EOF'
go/no-go v2: indicators error-rate plus latency, owner learner
budget: 10% errors for 2 minutes max, owner learner
rollback rehearsed: rollout.sh v1 in under 60s, owner learner
staffing: on-call present for 30 minutes post-ship, owner learner
comms draft: status page text ready, owner learner
decision: GO with accepted risk (v2 touches checkout path, watch first 5 minutes)
EOF
cat /tmp/dlab-m08-03/checklist.md
```

Every line owned before anything ships.

## 2. Roll out, detect, roll back

```bash
cd /tmp/dlab-m08-03
./rollout.sh v2
T0=$(date +%s)
./sample.sh 60 | tee indicators.csv
T1=$(date +%s)
echo "rule: rate over 10% -> ROLLBACK (indicators.csv)"
./rollout.sh v1
T2=$(date +%s)
{ echo "detect_secs=$((T1-T0))"; echo "rollback_secs=$((T2-T1))"; echo "total_secs=$((T2-T0))"; } | tee timings.txt
readlink current
```

The rule fires, the symlink swings, the clock testifies.

## 3. Verify and record

```bash
cd /tmp/dlab-m08-03
./sample.sh 30 | tee recovery.csv
curl -s http://127.0.0.1:18090/version | tee version-now.txt
{ echo "detection: $(grep detect_secs timings.txt)"; echo "rollback: $(grep rollback_secs timings.txt)"; echo "recovery: $(cat recovery.csv)"; echo "serving: $(cat version-now.txt)"; echo "next-fix: v3 must fix the every-third-request 500 before any new rollout"; } | tee drill-report.md
```

Green graph, old version, honest homework for v3.
