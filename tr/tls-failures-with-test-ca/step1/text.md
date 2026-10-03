# CA ve kusurlu denemeleri üret

Test CA üret; sonra üç sunucu sertifikası ver: süresi dolmuş, SAN'i yanlış isimli ve zincir dosyasında arası eksik doğru yaprak. CA sertifikasını ayrı ve YALNIZCA TEST etiketli tut.

**İpucu:** Her örneği openssl s_server ile sun: 18441 (sağlam), 18442 (yanlış SAN), 18443 (yalnızca yaprak, zincir yok). Her birini s_client -CAfile test-ca.crt ile teşhis et ve üç hata satırını alıntılayarak diagnosis.txt dosyasına yaz.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
