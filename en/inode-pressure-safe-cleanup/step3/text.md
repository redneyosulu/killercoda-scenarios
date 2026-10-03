# Clean in batches, verify each step

Delete in 'find ... -delete' batches (never bare 'rm *'), re-reading 'df -i' between batches. Finish with the directory removed and inodes back near the starting number. Record before/after.

**Hint:** Delete in find batches (never rm *), re-read df -i between batches, finish with the directory removed.

_When done, press **CHECK** to verify this step._
