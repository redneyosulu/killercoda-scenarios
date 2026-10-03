# Bound the resources

Measure peak memory under load, set a limit with headroom, and demonstrate the container surviving normal load while a deliberate over-allocation trips the limit. Record numbers.

**Hint:** Run a fresh container with --memory=128m, survive normal load plus a 40MB hold, record usage in limit.txt, then a 400MB hold must OOM (exit 137) with the proof in the same file.

_When done, press **CHECK** to verify this step._
