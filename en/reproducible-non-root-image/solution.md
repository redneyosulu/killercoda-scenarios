# Worked solution (repo reference, not shown in the UI)

## 1. Ship the naive image first

```bash
cd /tmp/dlab-m05-01
rm -rf naive && mkdir -p naive && cp ctx/server.py ctx/smoke.py ctx/requirements.txt naive/
cat > naive/Dockerfile <<'EOF'
FROM python:3
WORKDIR /app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 18085
CMD ["python3", "server.py"]
EOF
START=$(date +%s); docker build -t m05naive:1 naive/ >naive-build.log 2>&1; END=$(date +%s)
{ echo "size=$(docker images m05naive:1 --format '{{.Size}}')"; echo "build_secs=$((END-START))"; } | tee naive.txt
docker run -d --rm --name m05naive -p 18085:18085 m05naive:1 >/dev/null
for i in $(seq 1 30); do curl -sf http://127.0.0.1:18085/ >/dev/null 2>&1 && break; sleep 1; done
curl -s http://127.0.0.1:18085/ | tee -a naive.txt
docker exec m05naive id -u | tee -a naive.txt
docker stop m05naive >/dev/null
```

Full base, root, cache-busting order: the honest baseline.

## 2. Rebuild it properly

```bash
cd /tmp/dlab-m05-01
rm -rf proper && mkdir -p proper && cp ctx/server.py ctx/smoke.py ctx/requirements.txt proper/
cat > proper/.dockerignore <<'EOF'
data/
__pycache__/
*.log
.git
EOF
cat > proper/Dockerfile <<'EOF'
FROM python:3.12-slim-bookworm AS deps
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --target=/pkg -r requirements.txt
FROM python:3.12-slim-bookworm
ENV PYTHONPATH=/pkg
WORKDIR /app
RUN useradd -u 10001 -m app && mkdir -p /app/data && chown -R 10001:10001 /app
COPY --from=deps /pkg /pkg
COPY server.py smoke.py ./
RUN chown 10001:10001 /app/server.py /app/smoke.py
USER 10001
EXPOSE 18085
CMD ["python3", "server.py"]
EOF
START=$(date +%s); docker build -t m05proper:1 proper/ >proper-build.log 2>&1; END=$(date +%s)
START2=$(date +%s); docker build -t m05proper:1 proper/ >/dev/null 2>&1; END2=$(date +%s)
{ echo "size=$(docker images m05proper:1 --format '{{.Size}}')"; echo "build_secs=$((END-START))"; echo "rebuild_secs=$((END2-START2))"; } | tee proper.txt
```

Pinned, layered, ignored, non-root: every line earns its place.

## 3. Prove non-root and repeatability

```bash
cd /tmp/dlab-m05-01
docker run -d --rm --name m05proper -p 18085:18085 m05proper:1 >/dev/null
for i in $(seq 1 30); do curl -sf http://127.0.0.1:18085/ >/dev/null 2>&1 && break; sleep 1; done
docker exec m05proper id -u | tee idproof.txt
curl -s http://127.0.0.1:18085/write | tee -a idproof.txt
docker build --no-cache -q -t m05proper:r1 proper/ >/dev/null 2>&1
docker build --no-cache -q -t m05proper:r2 proper/ >/dev/null 2>&1
docker run --rm m05proper:r1 sh -c "find /app /pkg -type f -not -path '*__pycache__*' -exec md5sum {} + | sort" > content1.txt
docker run --rm m05proper:r2 sh -c "find /app /pkg -type f -not -path '*__pycache__*' -exec md5sum {} + | sort" > content2.txt
diff content1.txt content2.txt && echo REPRODUCIBLE | tee rebuild.txt
docker stop m05proper >/dev/null
```

Non-root writes succeed; identical file bytes mean an identical filesystem (image IDs still differ by build timestamp).
