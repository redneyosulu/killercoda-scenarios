# Çözüm notları

Arıza 1: `kubectl -n mock-run rollout undo deployment/app-b`, sonra Running podları bekle. Arıza 2: seçiciyi `app: app-a` değerine geri yama (`kubectl expose` etiket buydu), uçlar dolar. Arıza 3: `kubectl -n mock-run rollout resume deployment/app-a`.

İnceleme bloğu örneği: `arıza: ölü seçici / alan: networking / sınıf: yöntem / drill: beş serviste önce-uçlar kartı`. Eğitimde çözüme bakmak normaldir; sayılan sınavdır.
