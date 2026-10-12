# Dışarıdan görünüm

Aynı uygulamayı iki yolla aç, her yolun zincirini yaz:

```
kubectl expose deployment svc-target --name=outside-node --type=NodePort --port=80
```

Sonra `discover.test` alanını svc-target servisine yönlendiren `outside-web` Ingress yaz. Düğümden NodePort adresine, denetleyici koşuyorsa `/etc/hosts` ile alan adından curl at. Zinciri yaz: istemciden ingress'e, servise, uçlara, poda. KONTROL NodePort servisiyle Ingress kuralının varlığını doğrular.
