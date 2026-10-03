# Repair narrowly and verify

Apply the group repair (chgrp to a group you belong to, chmod 640) or the ownership repair, then verify with the same read command that failed in step 1. Confirm no file in the directory is wider than 640.

**Hint:** Apply your repair, then prove it: the same runuser read must succeed and no file may be wider than 640 (chmod 640 your denial.log and diagnosis.txt too).

_When done, press **CHECK** to verify this step._
