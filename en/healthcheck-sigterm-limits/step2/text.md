# Prove graceful stop

Send traffic, stop the container, and show in-flight requests completing before exit. Record stop duration and confirm no 5xx during a recreate cycle.

**Hint:** Curl /slow in the background, stop -t 30 the container, prove the in-flight request still returned 200 with exit code 0, record stop seconds in drain.txt, then start again with / still 200.

_When done, press **CHECK** to verify this step._
