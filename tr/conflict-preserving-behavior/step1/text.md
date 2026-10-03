# Çarpışmayı sahnele

Main dalında yavaş bağımlılık gerekçeli TIMEOUT=30 ata. Aynı tabandan dalda olay incelemesi gerekçeli TIMEOUT=10 ata. Birleştir ve çakışma işaretlerini doğrula.

**İpucu:** Main dalında depo başlat, taban yapılandırmayı commitler (TIMEOUT=20), o tabandan dalla, main üzerine TIMEOUT=30 (yavaş bağımlılık) ve dala TIMEOUT=10 (olay incelemesi) commitler, sonra birleştir ve çakışma işaretlerini ekranda tut.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
