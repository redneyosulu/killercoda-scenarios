# Worked solution (repo reference, not shown in the UI)

## 1. Write the naive version first

```bash
cat > /tmp/dlab-m03-02/naive.sh <<'EOF'
#!/bin/bash
D=/tmp/dlab-m03-02
mkdir -p "$D/state/data" "$D/state/logs"
echo "SERVER=app" >> "$D/state/app.conf"
echo "PORT=18083" >> "$D/state/app.conf"
echo "MODE=prod" >> "$D/state/app.conf"
echo "ready" > "$D/state/status"
EOF
chmod +x /tmp/dlab-m03-02/naive.sh
/tmp/dlab-m03-02/naive.sh
/tmp/dlab-m03-02/naive.sh
sort /tmp/dlab-m03-02/state/app.conf | uniq -d | tee /tmp/dlab-m03-02/dup-proof.txt
```

Second run duplicates every line: the naive script never converges.

## 2. Make every step idempotent

```bash
rm -rf /tmp/dlab-m03-02/state; mkdir -p /tmp/dlab-m03-02/state
cat > /tmp/dlab-m03-02/setup.sh <<'EOF'
#!/bin/bash
set -euo pipefail
S=/tmp/dlab-m03-02/state
[ -d "$S/data" ] || mkdir -p "$S/data"
[ -d "$S/logs" ] || mkdir -p "$S/logs"
for line in 'SERVER=app' 'PORT=18083' 'MODE=prod'; do
  grep -qxF "$line" "$S/app.conf" 2>/dev/null || echo "$line" >> "$S/app.conf"
done
printf 'ready\n' | cmp -s - "$S/status" || printf 'ready\n' > "$S/status"
EOF
chmod +x /tmp/dlab-m03-02/setup.sh
/tmp/dlab-m03-02/setup.sh
/tmp/dlab-m03-02/setup.sh
echo 'second run done'
```

Every step reads real state; reruns converge.

## 3. Add the dry-run contract

```bash
cat > /tmp/dlab-m03-02/setup.sh <<'EOF'
#!/bin/bash
set -euo pipefail
S=/tmp/dlab-m03-02/state
CHECK=0; [ "${1:-}" = "--check" ] && CHECK=1
PENDING=0
want_dir() { if [ -d "$1" ]; then [ $CHECK = 1 ] && echo "ok dir: $1"; else [ $CHECK = 1 ] && { echo "would create dir: $1"; PENDING=1; } || mkdir -p "$1"; fi; }
want_line() { if grep -qxF "$2" "$1" 2>/dev/null; then [ $CHECK = 1 ] && echo "ok: $2"; else [ $CHECK = 1 ] && { echo "would add: $2"; PENDING=1; } || echo "$2" >> "$1"; fi; }
want_dir "$S/data"
want_dir "$S/logs"
for line in 'SERVER=app' 'PORT=18083' 'MODE=prod'; do want_line "$S/app.conf" "$line"; done
if printf 'ready\n' | cmp -s - "$S/status"; then [ $CHECK = 1 ] && echo "ok: status"; else [ $CHECK = 1 ] && { echo "would write: status"; PENDING=1; } || printf 'ready\n' > "$S/status"; fi
exit $PENDING
EOF
chmod +x /tmp/dlab-m03-02/setup.sh
rm -rf /tmp/dlab-m03-02/state
/tmp/dlab-m03-02/setup.sh --check; echo "would-change exit: $?"
/tmp/dlab-m03-02/setup.sh
/tmp/dlab-m03-02/setup.sh --check; echo "converged exit: $?"
```

Dry-run contract holds in all three states.
