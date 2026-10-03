# Write the naive version first

Write a setup script that appends three config lines, creates two directories and writes a status file. Run it twice and diff the state after each run; the second diff must currently show duplication.

**Hint:** Write naive.sh that appends exactly these lines (SERVER=app, PORT=18083, MODE=prod), creates data/ and logs/, writes status. Run twice; save the duplication proof (sort | uniq -d) into dup-proof.txt.

_When done, press **CHECK** to verify this step._
