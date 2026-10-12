# Worked solution (repo reference, not shown in the UI)

## 1. Generate everything

```bash
D=/tmp/cd-m00-01
{ echo "# kubectl create pod dry-pod --image=nginx -o yaml --dry-run=client"; kubectl create pod dry-pod --image=nginx -o yaml --dry-run=client; } > $D/pod.yaml
{ echo "# kubectl create deployment dry-deploy --image=nginx -o yaml --dry-run=client"; kubectl create deployment dry-deploy --image=nginx -o yaml --dry-run=client; } > $D/deploy.yaml
{ echo "# kubectl create service clusterip dry-svc --tcp=80:80 -o yaml --dry-run=client"; kubectl create service clusterip dry-svc --tcp=80:80 -o yaml --dry-run=client; } > $D/svc.yaml
kubectl apply --dry-run=client -f $D/
```

Generator on top, manifest below, validation green.

## 2. Loop it

```bash
D=/tmp/cd-m00-01
kubectl apply -f $D/ | tee -a $D/session-note.txt
kubectl set image deployment/dry-deploy nginx=nginx:1.27 | tee -a $D/session-note.txt
kubectl rollout status deployment/dry-deploy | tee -a $D/session-note.txt
kubectl rollout undo deployment/dry-deploy | tee -a $D/session-note.txt
kubectl rollout history deployment/dry-deploy
```

Apply, change, confirm, roll back: history keeps the receipt.
