# İki arızayı da yerleştir

18080 portunda dinleyici başlat. svc-lab.test ismini 127.0.0.2 adresine sabitleyen hosts girdisi ekle (yanlış adres); test istemcini 19090 portuna yönelt (yanlış port). Testten önce iki arızayı da yaz.

**İpucu:** İki hatayı faults.txt dosyasına yaz (yanlış adres 127.0.0.2, yanlış port 19090), sonra hatayı kanıtla: svc-lab.test:19090 adresine curl yap ve hatayı kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
