# Çözüm notları

1. adım: `/bin/false` hemen çıkar, kubelet BackOff döngüsünde yeniden başlatır. Describe artan yeniden başlatma sayısını gösterir; `--previous` logları boştur çünkü false hiçbir şey yazmaz: bu boşluk bile hükümdür (bozuk komut, okunacak şey yok). `sleep 3600` ile yeniden kur.

2. adım: `kubectl create deployment shop` podları `app=shop` etiketler. `app=shop-wrong` seçen servis boş uç verir: seçiciyi düzelt, uçlar dolar, curl cevap verir.

3. adım: aynı iki düzeltme, süreli. Çoğu öğrenci ikinci turun iki kat hızlı olduğunu görür: yöntem aramanın yerini aldı. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
