# Prove non-root and repeatability

Run as the numeric user, write to the app's writable path, and show id -u output from inside. Rebuild twice from clean cache state and show identical image digests.

**Hint:** Run proper, prove UID 10001 from inside plus a write to the app path, then two clean --no-cache rebuilds with byte-identical file content recorded in rebuild.txt.

_When done, press **CHECK** to verify this step._
