# Üç dosya, sıfır yazım

Üç bildirimi de ev dizinine üret:

```
kubectl run gen-pod --image=nginx:1.25 --dry-run=client -o yaml > ~/pod.yaml
kubectl create deployment gen-app --image=nginx:1.25 --dry-run=client -o yaml > ~/deploy.yaml
kubectl expose deployment gen-app --name=gen-svc --port=80 --dry-run=client -o yaml > ~/svc.yaml
```

KONTROL her dosyanın var ve doğru `kind` taşıdığını doğrular (Pod, Deployment, Service). Tür yanlışsa komutları karıştırmışsındır: yeniden üret.
