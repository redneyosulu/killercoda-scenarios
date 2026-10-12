# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Süreli arama

```bash
D=/tmp/ck-m00-02
{
  echo "topologySpreadConstraints: 38s"
  echo "startupProbe: 24s"
  echo "volumeClaimTemplates: 51s"
} | tee -a $D/session-note.txt
```

Alanların ve sürelerin senin; baraj 60ın altında üç satır.

## 2. Belgeden kümeye

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

Önce aynen uygula, sonra tek alan, kaynak kayıtta.
