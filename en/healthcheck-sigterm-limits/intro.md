# Verify Health Checks, SIGTERM Handling and Resource Limits

**Environment.** Ubuntu 24.04, About 50 minutes.

## What you will do

- Add a readiness check on a real dependency path with warmup cover
- Prove graceful SIGTERM drain with in-flight requests
- Set a memory limit from measured peak and show the OOM boundary

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
