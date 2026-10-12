# Worked solution (repo reference, not shown in the UI)

## 1. Timed search

```bash
D=/tmp/ck-m00-02
{
  echo "topologySpreadConstraints: 38s"
  echo "startupProbe: 24s"
  echo "volumeClaimTemplates: 51s"
} | tee -a $D/session-note.txt
```

Your fields and your seconds; the bar is three lines under 60.

## 2. Docs to cluster

```bash
D=/tmp/ck-m00-02
cat > $D/docs-pod.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: docs-pod
spec:
  containers:
  - name: web
    image: nginx
EOF
kubectl apply -f $D/docs-pod.yaml
kubectl label pod docs-pod edited=true
echo "https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes/" | tee -a $D/session-note.txt
```

Unchanged apply first, exactly one field after, source on record.
