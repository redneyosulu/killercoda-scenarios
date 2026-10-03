# Stage the collision

On main, set TIMEOUT=30 with a commit message about a slow dependency. On a branch from the same base, set TIMEOUT=10 with a message about an incident review. Merge and confirm the conflict markers.

**Hint:** Init repo on branch main, commit a base config (TIMEOUT=20), branch from that base, commit TIMEOUT=30 on main (slow dependency) and TIMEOUT=10 on the branch (incident review), then merge and keep the conflict markers on screen.

_When done, press **CHECK** to verify this step._
