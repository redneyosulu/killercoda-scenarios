# Yapılandırma ve gizliler

Yapılandırma imajdan ayrı taşınır: sabit değer ve dosyalar ConfigMap olur, hassas değerler Secret olur, podlar ikisini de ortam değişkeni ya da dosya olarak tüketir. Bu senaryoda her türü kuracak, tek poda iki farklı yolla bağlayacak, gizliyi hiç yazdırmadan içeriden tüketimi kanıtlayacaksın.
