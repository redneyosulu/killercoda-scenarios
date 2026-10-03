# Her kusuru teşhis et

Her denemeyi farklı yerel portta openssl s_server ile sun; test CA'yi -CAfile ile gösteren s_client çalıştır. Üç durumun doğrulama dönüş kodunu ve kusuru adlandıran satırı kaydet.

**İpucu:** fullchain.pem dosyasını birleştir (sağlam yaprak + ara sertifika) ve -build_chain -chainCAfile test-ca-full.crt bayraklarıyla 18445 portunda sun (modern s_server bayraksız yalnızca yaprağı gönderir). -CAfile ile 0 dönüş kodunu doğrula, satırı fixed.txt dosyasına kaydet. Asla --insecure veya doğrulama atlatma kullanma.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
