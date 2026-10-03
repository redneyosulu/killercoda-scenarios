# Worked solution (repo reference, not shown in the UI)

## 1. Add a real healthcheck

```bash
cd /tmp/dlab-m05-03
cat > app/Dockerfile <<'EOF'
FROM python:3.12-slim-bookworm
WORKDIR /app
COPY server.py ./
HEALTHCHECK --interval=5s --timeout=3s --start-period=25s --retries=3 CMD python3 -c "import urllib.request,sys; sys.exit(0 if urllib.request.urlopen('http://127.0.0.1:18088/ready', timeout=2).status==200 else 1)"
EXPOSE 18088
CMD ["python3", "server.py"]
EOF
docker build -t m05hc:1 app/ >hc-build.log 2>&1
docker rm -f m05hc >/dev/null 2>&1 || true
START=$(date +%s)
docker run -d --name m05hc -p 18088:18088 m05hc:1 >/dev/null
curl -s -o /dev/null -w 'early:%{http_code}\n' http://127.0.0.1:18088/ready | tee warmup.txt
while [ "$(curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:18088/ready)" != "200" ]; do sleep 1; done
echo "warmup_secs=$(( $(date +%s) - START ))" | tee -a warmup.txt
for i in $(seq 1 24); do [ "$(docker inspect --format '{{.State.Health.Status}}' m05hc)" = "healthy" ] && break; sleep 5; done
docker inspect --format 'health:{{.State.Health.Status}}' m05hc | tee healthy.txt
```

The check fails warm, passes ready, and Docker agrees: healthy.

## 2. Prove graceful stop

```bash
cd /tmp/dlab-m05-03
curl -s --max-time 30 http://127.0.0.1:18088/slow >drain-out.txt 2>&1 &
CURLPID=$!
sleep 1
S0=$(date +%s); docker stop -t 30 m05hc >/dev/null; S1=$(date +%s)
wait $CURLPID || true
{ echo "slow_body=$(cat drain-out.txt)"; echo "stop_secs=$((S1-S0))"; echo "exit_code=$(docker inspect --format '{{.State.ExitCode}}' m05hc)"; } | tee drain.txt
docker start m05hc >/dev/null
sleep 2; curl -s -o /dev/null -w 'after_restart:%{http_code}\n' http://127.0.0.1:18088/ | tee -a drain.txt
```

SIGTERM waits for the in-flight request; the restart serves clean.

## 3. Bound the resources

```bash
cd /tmp/dlab-m05-03
docker rm -f m05mem >/dev/null 2>&1 || true
docker run -d --name m05mem --memory=128m -p 18088:18088 m05hc:1 >/dev/null
for i in $(seq 1 45); do curl -sf http://127.0.0.1:18088/ready >/dev/null 2>&1 && break; sleep 2; done
curl -s http://127.0.0.1:18088/ | tee limit.txt
curl -s "http://127.0.0.1:18088/alloc?mb=40" | tee -a limit.txt
docker stats --no-stream --format 'usage:{{.MemUsage}}' m05mem | tee -a limit.txt
curl -s --max-time 25 "http://127.0.0.1:18088/alloc?mb=400" >>limit.txt 2>&1 || true
sleep 3
{ echo "OOMKilled: $(docker inspect --format '{{.State.OOMKilled}}' m05mem)"; echo "exit: $(docker inspect --format '{{.State.ExitCode}}' m05mem)"; } | tee -a limit.txt
docker rm -f m05hc m05mem >/dev/null 2>&1 || true
```

Headroom holds normal load; four hundred megabytes meets the wall at 137.
