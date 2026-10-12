# Worked solution (repo reference, not shown in the UI)

## 1. Open the cluster

```bash
kubectl get nodes
kubectl get nodes -o wide
echo "k8s-version: $(kubectl version -o json | grep '"gitVersion"' | head -1 | cut -d'"' -f4)" | tee -a /tmp/ck-m00-01/session-note.txt
```

Version first, commands second.

## 2. Imperative sprint

```bash
D=/tmp/ck-m00-01
kubectl create deployment speed-demo --image=nginx | tee -a $D/session-note.txt
kubectl expose deployment speed-demo --port=80 | tee -a $D/session-note.txt
kubectl scale deployment speed-demo --replicas=3 | tee -a $D/session-note.txt
kubectl get deployment speed-demo
kubectl delete deployment speed-demo | tee -a $D/session-note.txt
kubectl delete svc speed-demo | tee -a $D/session-note.txt
```

Flags only, then a clean cluster.

## 3. Templates that save minutes

```bash
D=/tmp/ck-m00-01
{
  echo "alias k=kubectl"
  echo "source <(kubectl completion bash)"
  echo "kubectl create deployment NAME --image=nginx -o yaml --dry-run=client > deploy.yaml"
  echo "kubectl explain pods.spec.containers"
} | tee -a $D/session-note.txt
kubectl explain pods.spec.containers | head -20
```

Three reusable lines plus one answered question.
