# Slow starter, right probes

Deploy `slow-app` (nginx image) with a command that sleeps 20 seconds before starting nginx. Without a startup probe, liveness would kill it in a loop. Fit the set:

- startupProbe: httpGet `/`, covering at least 30 seconds of delay
- livenessProbe plus readinessProbe: httpGet `/` for steady state

Prove with describe that the pod reaches Running with zero restarts. CHECK verifies Running phase, restart count zero, and all three probes present in the spec.
