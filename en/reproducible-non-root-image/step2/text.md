# Rebuild it properly

Convert to multi-stage with pinned base, dependency-first layer order, .dockerignore, USER 10001 with owned writable paths. Rebuild and record size plus no-change rebuild time.

**Hint:** Write proper/Dockerfile: pinned slim base, dependency-first multi-stage, .dockerignore, numeric USER 10001 with owned writable /app/data. Rebuild, record size plus no-change rebuild seconds in proper.txt.

_When done, press **CHECK** to verify this step._
