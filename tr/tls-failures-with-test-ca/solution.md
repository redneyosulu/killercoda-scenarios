# Çözümlü anlatım (depo referansı, arayüzde görünmez)

## 1. Build the CA and the flawed fixtures

```bash
openssl s_server -accept 18441 -cert /tmp/dlab-m02-03/leaf-good.crt -key /tmp/dlab-m02-03/leaf-good.key -www &>/tmp/dlab-m02-03/s1.log &
openssl s_server -accept 18442 -cert /tmp/dlab-m02-03/leaf-wrong.crt -key /tmp/dlab-m02-03/leaf-wrong.key -www &>/tmp/dlab-m02-03/s2.log &
openssl s_server -accept 18443 -cert /tmp/dlab-m02-03/leaf-good.crt -key /tmp/dlab-m02-03/leaf-good.key -www &>/tmp/dlab-m02-03/s3.log &
sleep 1
echo | openssl s_client -connect 127.0.0.1:18441 -CAfile /tmp/dlab-m02-03/test-ca.crt -attime 2000000000 2>&1 | grep -E 'Verify return code'
echo | openssl s_client -connect 127.0.0.1:18442 -CAfile /tmp/dlab-m02-03/test-ca.crt -verify_hostname svc-lab.test 2>&1 | grep -E 'Verify return code'
echo | openssl s_client -connect 127.0.0.1:18443 -CAfile /tmp/dlab-m02-03/test-ca.crt 2>&1 | grep -E 'Verify return code'
printf 'expired: certificate has expired\nwrong-san: Hostname mismatch\nchain: unable to verify the first certificate\n' > /tmp/dlab-m02-03/diagnosis.txt
```

Üç hata, üç alıntılanmış doğrulama satırı, güven hep açık.

## 2. Diagnose each flaw

```bash
cat /tmp/dlab-m02-03/leaf-good.crt /tmp/dlab-m02-03/test-int.crt > /tmp/dlab-m02-03/fullchain.pem
openssl s_server -accept 18445 -cert /tmp/dlab-m02-03/fullchain.pem -key /tmp/dlab-m02-03/leaf-good.key -build_chain -chainCAfile /tmp/dlab-m02-03/test-ca-full.crt -www &>/tmp/dlab-m02-03/s4.log &
sleep 1
echo | openssl s_client -connect 127.0.0.1:18445 -CAfile /tmp/dlab-m02-03/test-ca.crt 2>&1 | grep 'Verify return code' | tee /tmp/dlab-m02-03/fixed.txt
```

Tam zincir sunuldu, açık güven, 0 dönüş kodu.

## 3. Show the right repair per case

```bash
printf 'expired: reissue with valid dates\nwrong-san: reissue with the correct SAN\nchain: serve the full chain\n' > /tmp/dlab-m02-03/repairs.txt
ls /tmp/dlab-m02-03/TEST-ONLY.txt
```

Onarımlar adlandırıldı, test CA etiketli ve sınırlı.
