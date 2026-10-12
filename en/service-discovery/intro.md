# Service discovery

Apps find each other by names that survive pod churn. In this scenario you resolve a service three ways from a debug pod, expose it outside through NodePort and Ingress, then break the selector and fix it inside five minutes.
