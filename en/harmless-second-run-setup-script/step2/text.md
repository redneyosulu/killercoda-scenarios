# Make every step idempotent

Convert each step to check-then-change against real state (grep -qxF for lines, test -d for directories, cmp for file contents). Re-run twice; both diffs after the first must be empty.

**Hint:** From a fresh state dir, write setup.sh with check-then-change steps (grep -qxF, test -d, cmp), no marker files. Two runs after the first must be empty diffs.

_When done, press **CHECK** to verify this step._
