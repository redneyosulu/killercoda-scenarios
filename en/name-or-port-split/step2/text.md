# Split name from port

Run getent hosts svc-lab.test and dig +short svc-lab.test (or the resolver-free equivalent) and state which answers differ. Then test the port against the correct address directly with curl or nc. Name the guilty layer with quoted output.

**Hint:** Split the layers: getent hosts vs python socket resolve for the name, then curl 127.0.0.1:18080 directly for the port. Write split.txt naming the NAME layer guilty, and save the direct 200 into direct.txt.

_When done, press **CHECK** to verify this step._
