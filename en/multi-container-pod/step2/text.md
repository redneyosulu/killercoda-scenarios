# Rightsize it

Deploy `sized-app` (nginx) and set requests near the floor and limits near the ceiling: CPU request 100m with limit 500m, memory request 128Mi with limit 256Mi. If `kubectl top` answers in this environment, compare your numbers against observed usage first and adjust.

Write one sentence per number saying why it sits where it does. CHECK verifies all four values exist on the container; your sentences are the real exercise.
