# Add a real healthcheck

Implement /ready testing the stub dependency, with start-period covering measured warmup. Show the check failing before warm and passing after.

**Hint:** Write app/Dockerfile with a HEALTHCHECK on /ready and a start-period covering the ~15s warmup. Build, run, record the 503-then-200 warmup seconds in warmup.txt and the healthy state in healthy.txt.

_When done, press **CHECK** to verify this step._
