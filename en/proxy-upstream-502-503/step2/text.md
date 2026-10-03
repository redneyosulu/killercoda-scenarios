# Break it twice, read both sides

First stop the upstream and record the proxy status and time-to-answer (expect fast 502). Then restart it in a mode that answers 503 or hangs past the proxy timeout (expect 503 or slow 504). Quote one proxy log line and one upstream log line per case with timestamps.

**Hint:** Kill the upstream (kill $(cat UPSTREAM.pid)), curl for the fast 502 into case502.log; restart it with UPSTREAM_MODE=fail503, curl into case503.log. Quote one proxy line per case.

_When done, press **CHECK** to verify this step._
