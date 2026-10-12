# İki yolla ConfigMap

Bir ConfigMap'i sabit değerden, birini dosyadan kur, sonra tek podda farklı tüket:

```
kubectl create configmap app-literal --from-literal=MODE=prod
echo "hello from file" > ~/greeting.txt
kubectl create configmap app-file --from-file=~/greeting.txt
```

`cfg-test` podunu çalıştır (busybox, sleep 3600): MODE ortam değişkeni app-literal'den, dosya `/etc/greeting` altında birimden gelsin. İkisini de içeriden kanıtla: `printenv MODE` ve `cat /etc/greeting/greeting.txt`. KONTROL aynı iki okumayı doğrular.
