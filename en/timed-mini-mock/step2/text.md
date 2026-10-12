# Run it flagged

Plant the three faults, start the timer, fix them with flag discipline:

```
kubectl -n mock-run set image deployment/app-b nginx=nginx:9.99-does-not-exist
kubectl -n mock-run patch service front -p '{"spec":{"selector":{"app":"front-wrong"}}}'
kubectl -n mock-run rollout pause deployment/app-a
```

Diagnose in any order, but flag anything stuck past two minutes and return later. Causes: bad image (rollout stall), dead selector (empty endpoints), paused rollout (status says paused). Fix all three: undo the image, correct the selector, resume the rollout. The last five minutes are verification only. CHECK verifies all three fixes at once.
