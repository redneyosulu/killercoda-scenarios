# Belgeden kümeye

Belgeden bir Pod örneği al, `docs-pod` adıyla aynen uygula. Sonra tek alanı değiştir: `edited=true` etiketini ekle. Örneğin hangi sayfadan geldiğini kaydet.

**İpucu:** Örneği `/tmp/ck-m00-02/docs-pod.yaml` dosyasına kaydet, `kubectl apply -f` ile uygula, sonra `kubectl label pod docs-pod edited=true` çalıştır. Belge sayfasının tam adresini (`https://kubernetes.io/docs` ile başlayan) oturum notuna ekle.

_Bitince bu adımı doğrulamak için **CHECK** düğmesine bas._
