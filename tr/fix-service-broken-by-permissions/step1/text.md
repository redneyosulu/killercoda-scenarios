# Bozuk sahneyi kur

600 modda sana ait bir konfigürasyon dosyasıyla /tmp/dlab-m01-01 dizinini oluştur; sonra servis kullanıcısını varsa 'sudo -u nobody head' ile taklit et, sudo yoksa 'id' ve 'ls -l' çıktısından muhakeme et. Tam ret satırını kaydet.

**İpucu:** `runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf` komutunu çalıştır ve red satırını `2>` ile denial.log dosyasına kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
