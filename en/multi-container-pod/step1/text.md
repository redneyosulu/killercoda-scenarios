# Sidecar log shipper

Run pod `shipper` with an emptyDir volume named `shared`: the main busybox container appends `hello from main` to `/shared/log.txt` every few seconds, the sidecar busybox container tails that file to its own stdout.

Prove the sharing end to end: read the file from inside the main container, then read the sidecar's logs and find the same lines there. CHECK verifies the sidecar's stdout carries the main container's lines.
