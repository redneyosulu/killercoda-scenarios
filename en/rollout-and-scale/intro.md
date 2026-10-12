# Rollout and scale

Deployments keep N identical replicas running and replace the dead. In this scenario you deploy a web app, scale it, expose it inside the cluster, roll it forward, break it on purpose, and roll it back from history.

Everything is imperative: no YAML files in this round. Speed comes from flags.
