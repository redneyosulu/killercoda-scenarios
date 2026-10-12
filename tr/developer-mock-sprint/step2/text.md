# Tavanlı koş

Tahta kurulu; uygulamayı tavanlarla bitir: configmap'i envFrom ile, gizli anahtarı ortam değişkeni olarak dağıtıma bağla (yeniden üret ya da düzenle ve uygula), startupProbe ve livenessProbe uyarla, servisin uçlarını doğrula. Ayıklama takılmasına iki dakika işaret kuralı; yazarlık takılmasına sekiz dakika, sonra işaret.

Her uygulamadan önce dry-run ile geçerle; supürmeyle kapat: podlar hazır, cevaplar tutuyor, tekrar uygulama yok. KONTROL tanımda sondajları ve canlı uçları doğrular.
