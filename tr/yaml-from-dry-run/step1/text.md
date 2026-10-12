# Hepsini üret

Üç bildirimi yalnızca dry-run ile üret: `dry-pod` podu, `dry-deploy` deploymenti, ClusterIP `dry-svc` servisi. Bu turda elle YAML yazmak yasak. Her dosyanın ilk satırına üreten komutu yorum satırı olarak yaz.

**İpucu:** `kubectl create pod dry-pod --image=nginx -o yaml --dry-run=client`, `kubectl create deployment dry-deploy --image=nginx -o yaml --dry-run=client`, `kubectl create service clusterip dry-svc --tcp=80:80 -o yaml --dry-run=client`. Her çıktıyı komut yorumuyla birlikte `/tmp/cd-m00-01/pod.yaml`, `deploy.yaml`, `svc.yaml` dosyalarına yönlendir.

_Bitince bu adımı doğrulamak için **CHECK** düğmesine bas._
