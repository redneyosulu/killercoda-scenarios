# Test first, then resolve

Before touching markers, write the smallest check capturing the combined intent (per-environment values, or the documented compromise). Then resolve the file to satisfy that check and clear all markers.

**Hint:** Write check.sh FIRST capturing the combined intent (both the 30 and the 10 survive in some form), watch it fail on the marked file, then resolve app.conf so the check passes with zero markers.

_When done, press **CHECK** to verify this step._
