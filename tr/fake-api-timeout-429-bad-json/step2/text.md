# Sertleştirilmiş istemciyi yaz

Bağlantı/toplam zaman aşımlı, en fazla 3 denemeli geri çekilmeli, Retry-After'a uyan, varsayılanlı jq -e ayrıştırmalı getirme-kapı betiği yaz. Her sabit (deneme, uyku, bütçe) üstte görünür.

**İpucu:** fetch.sh <yol> dosyasını yaz: üstte TIMEOUT, MAX_ATTEMPTS, BACKOFF sabitleri; curl bağlantı/toplam zaman aşımı; en fazla 3 deneme; 429 durumunda Retry-After saygısı; jq -e ayrıştırma; bozuk JSON durumunda temiz sıfır-dışı çıkış.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
