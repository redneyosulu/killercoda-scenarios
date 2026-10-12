# Config and secrets

Configuration ships separately from images: literals and files become ConfigMaps, sensitive values become Secrets, pods consume both as env or files. In this scenario you build each kind, wire them into a pod two different ways, and prove consumption from inside without ever printing the secret.
