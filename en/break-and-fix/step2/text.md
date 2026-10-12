# Selector drill

Deploy the app, then deliberately point a Service at labels that match nothing:

```
kubectl create deployment shop --image=nginx:1.25
```

Write a Service `shop-broken` by hand with selector `app: shop-wrong` on port 80. Diagnose endpoints-first (`kubectl get endpoints shop-broken` is empty), fix the selector to `app: shop`, and prove it with a curl from a debug pod. CHECK verifies non-empty endpoints on the fixed selector.
