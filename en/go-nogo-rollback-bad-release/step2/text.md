# Roll out, detect, roll back

Ship the bad version to the fixture, watch the indicators cross the rollback rule (error rate plus timebox), and roll back to the previous digest. Time every step from detection to recovery.

**Hint:** Ship v2, sample 60 requests into indicators.csv, call rollback by rule (rate over 10%), roll back to the v1 digest, time detect plus rollback into timings.txt.

_When done, press **CHECK** to verify this step._
