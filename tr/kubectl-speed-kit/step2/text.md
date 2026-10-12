# Emir kipi sprinti

Döngüyü yalnızca bayraklarla kur: nginx tabanlı `speed-demo` deploymenti, 80. portu dışarı aç, 3 kopyaya ölçekle, sonra iki nesneyi de sil. Bu turda YAML dosyası yasak. Çalıştırdığın her komutu oturum notuna ekle.

**İpucu:** `kubectl create deployment speed-demo --image=nginx`, `kubectl expose deployment speed-demo --port=80`, `kubectl scale deployment speed-demo --replicas=3`, sonra `kubectl delete deployment speed-demo` ve `kubectl delete svc speed-demo`. Her satırı nota kaydet.

_Bitince bu adımı doğrulamak için **CHECK** düğmesine bas._
