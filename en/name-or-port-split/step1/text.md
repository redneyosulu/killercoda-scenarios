# Plant both faults

Start a listener on port 18080. Add a hosts pin mapping svc-lab.test to 127.0.0.2 (wrong address), and aim your test client at port 19090 (wrong port). Write both faults down before testing.

**Hint:** Write faults.txt with both faults (wrong address 127.0.0.2, wrong port 19090), then prove the failure: curl svc-lab.test:19090 and save the error.

_When done, press **CHECK** to verify this step._
