# Multi-container pod

One pod, two containers, one shared volume: the main app writes logs to a file, the sidecar tails that file to stdout where the platform collects it. Then you rightsize the pod with requests near the floor and limits near the ceiling, each with a one-sentence reason.
