# Yardımcı log taşıyıcı

`shipper` podunu `shared` adlı emptyDir birimiyle çalıştır: ana busybox kapsayıcısı birkaç saniyede bir `/shared/log.txt` dosyasına `hello from main` satırı eklesin, yardımcı busybox kapsayıcısı dosyayı kuyruktan okuyup kendi standart çıktısına taşısın.

Paylaşımı uçtan uca kanıtla: dosyayı ana kapsayıcının içinden oku, sonra yardımcının loglarında aynı satırları bul. KONTROL yardımcının çıktısında ana kapsayıcının satırlarını doğrular.
