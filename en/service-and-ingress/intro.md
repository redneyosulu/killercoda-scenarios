# Service and ingress

Services give stable addresses to churning pods; Ingress routes outside HTTP traffic by hostname; NetworkPolicies close what should stay closed.

You will expose one deployment three ways and compare reachability from a test pod, route two hostnames through a single Ingress object, then prove a default-deny policy with curls that fail and one that answers.
