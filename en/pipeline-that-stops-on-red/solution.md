# Worked solution (repo reference, not shown in the UI)

## 1. Lay the stages in cost order

```bash
cat > /tmp/dlab-m06-01/pipeline.sh <<'EOF'
#!/bin/bash
D=/tmp/dlab-m06-01
R=$D/repo
log=${1:-$D/run.log}
exec >"$log" 2>&1
pass=true
stage(){
  local name=$1; shift
  if [ "$pass" = false ]; then echo "SKIP $name (upstream red)"; return 0; fi
  echo "START $name"
  local s0=$(date +%s)
  if "$@"; then echo "PASS $name $(( $(date +%s) - s0 ))s"
  else echo "FAIL $name $(( $(date +%s) - s0 ))s"; echo "REJECTED-BY $name"; pass=false; fi
}
stage checkout git -C "$R" rev-parse --short HEAD
stage lint shellcheck "$R/app.sh"
stage unit bash "$R/test_app.sh"
stage build bash "$R/build.sh"
stage package bash "$R/package.sh"
if [ "$pass" = true ]; then echo "PIPELINE GREEN"; else echo "PIPELINE RED"; exit 1; fi
EOF
chmod +x /tmp/dlab-m06-01/pipeline.sh
/tmp/dlab-m06-01/pipeline.sh /tmp/dlab-m06-01/green-run.log; echo "exit: $?"
grep -E "^(PASS|FAIL)" /tmp/dlab-m06-01/green-run.log | tee /tmp/dlab-m06-01/stages.txt
```

Cheap checks first, every stage timed, package only on green.

## 2. Introduce a real failure

```bash
cd /tmp/dlab-m06-01/repo
sed -i 's/hello mars/hello venus/' test_app.sh
git commit -qam "break: venus expectation" || true
/tmp/dlab-m06-01/pipeline.sh /tmp/dlab-m06-01/fail-run.log; echo "exit: $?"
grep -E "FAIL|SKIP|REJECTED|PIPELINE" /tmp/dlab-m06-01/fail-run.log
```

One wrong expectation halts everything below it.

## 3. Repair and show green

```bash
cd /tmp/dlab-m06-01/repo
sed -i 's/hello venus/hello mars/' test_app.sh
bash test_app.sh
git commit -qam "fix: mars expectation restored" || true
/tmp/dlab-m06-01/pipeline.sh /tmp/dlab-m06-01/green-run2.log; echo "exit: $?"
ls /tmp/dlab-m06-01/repo/dist/*.tar.gz | tee /tmp/dlab-m06-01/artifact.txt
```

Green again, artifact stamped, both run records kept.
