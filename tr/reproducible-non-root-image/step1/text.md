# Önce saf imajı çıkar

Tek aşamalı, root, sabitlenmemiş tabanlı, bağımlılıklardan önce uygulamayı kopyalayan imaj derle. İmaj boyutunu ve tam derleme süresini kaydet.

**İpucu:** ctx/ içeriğini naive/ dizinine kopyala, tek aşamalı Dockerfile yaz (sabitlenmemiş python:3 tabanı, pip kurulumundan önce hepsini KOPYALA, varsayılan root), derle, boyut ve tam derleme saniyesini naive.txt dosyasına kaydet, bir kez çalıştırıp içerideki UID değerini kaydet.

_Bitirince bu adımı doğrulamak için **CHECK** düğmesine bas._
