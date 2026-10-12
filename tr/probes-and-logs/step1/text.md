# Yavaş başlayan, doğru sondaj

`slow-app` dağıtımını kur (nginx imajı), komut nginx'ten önce 20 saniye uyusun. Başlangıç sondajı olmadan canlılık onu döngüde öldürürdü. Seti uyarla:

- startupProbe: httpGet `/`, en az 30 saniyelik gecikmeyi kapsasın
- livenessProbe ve readinessProbe: kararlı hal için httpGet `/`

Describe ile podun sıfır yeniden başlatmayla Running olduğunu kanıtla. KONTROL Running durumunu, sıfır sayıyı ve tanımda üç sondajı doğrular.
