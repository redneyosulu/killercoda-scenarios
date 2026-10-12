# Docs to cluster

Take one Pod example from the docs and apply it unchanged as pod `docs-pod`. Then modify exactly one field: add the label `edited=true`. Record which page the example came from.

**Hint:** Save the example to `/tmp/ck-m00-02/docs-pod.yaml`, run `kubectl apply -f` on it, then `kubectl label pod docs-pod edited=true`. Append the full docs page URL (starting with `https://kubernetes.io/docs`) to the session note.

_When done, press **CHECK** to verify this step._
