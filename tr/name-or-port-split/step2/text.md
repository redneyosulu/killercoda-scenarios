# İsmi porttan ayır

getent hosts svc-lab.test ve dig +short svc-lab.test (veya çözümleyicisiz eşdeğeri) çalıştır; yanıtların nerede ayrıldığını söyle. Sonra doğru adrese karşı portu doğrudan curl veya nc ile test et. Suçlu katmanı alıntılı çıktıyla adlandır.

**İpucu:** Katmanları ayır: isim için getent hosts ile python socket çözümünü karşılaştır, port için doğrudan 127.0.0.1:18080 adresine curl yap. split.txt dosyasına suçlu olarak İSİM katmanını yaz, doğrudan 200 cevabını direct.txt dosyasına kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
