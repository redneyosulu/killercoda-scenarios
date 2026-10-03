# İki arıza yerleştir

'APP_PORT=8080 myapp' çalıştıran minimal birim (veya başlatma betiği) al. A arızası: APP_PORT'u sayı yerine kelime yapan ortam dosyası. B arızası: ExecStart'ı yeniden adlandırılmış ikili yola gösteren birim. İkisini de ayrı ayrı yaz.

**İpucu:** myapp.unit ve app.env dosyalarını aç, hiçbir şeyi başlatmadan önce A hatasını (hatalı değer) ve B hatasını (yanlış ikili yol) faults.txt dosyasına yaz.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
