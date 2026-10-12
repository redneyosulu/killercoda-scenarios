# Timed round

Reset both breaks and redo them against the clock: ten minutes each, flag rule on.

```
kubectl delete pod crasher
kubectl delete service shop-broken
```

Rebuild the CrashLoop, diagnose, fix. Rebuild the wrong selector, diagnose endpoints-first, fix, curl to prove. Log where the minutes actually went: that gap is the training target. CHECK verifies both end states hold at once.
