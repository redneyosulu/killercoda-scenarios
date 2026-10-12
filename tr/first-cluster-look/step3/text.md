# Bağlam güvenliği

Yanlış bağlamdaki iş sıfır puan alır; gidiş dönüşü kanıtla:

```
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <diger-baglam>
kubectl config use-context <ilk-baglam>
kubectl get nodes
```

Kümede tek bağlam varsa önce ikincisini kur (aynı kümeye yeni adla kopyala), ona geç, sonra geri dön. Son `get nodes` cevap vermeli: bu, doğru yerde olduğunu kanıtlar.

KONTROL güncel bağlamın kurulu olduğunu, en az bir bağlam varlığını ve kümenin cevap verdiğini doğrular.
