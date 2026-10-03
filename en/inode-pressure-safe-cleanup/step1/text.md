# Create bounded pressure

Record 'df -i /tmp' first. Generate up to 60,000 small files in /tmp/dlab-m01-03 with a loop, watching 'df -i' move. Stop at 60,000 regardless: this lab proves the method, not the limit.

**Hint:** Confirm the pressure: count files (ls | wc -l), read df -i /tmp, and write numbers.txt with baseline used, now used, file count.

_When done, press **CHECK** to verify this step._
