# Fix upstream only

Restore the healthy upstream, confirm 200s, and show with ss -tlnp that exactly one listener holds each port. The proxy configuration stays untouched throughout.

**Hint:** Restart the healthy upstream (no env mode), confirm 200, show one listener per port with ss, and prove proxy.py untouched (compare sha256 with proxy.sha).

_When done, press **CHECK** to verify this step._
