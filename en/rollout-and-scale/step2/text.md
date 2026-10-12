# Rolling update

Change the image and watch the rollout converge:

```
kubectl set image deployment/web nginx=nginx:1.26
kubectl rollout status deployment/web
kubectl rollout history deployment/web
```

Note how many pods stay available during the roll: that number is the point of the exercise. CHECK verifies the history holds at least two revisions.
