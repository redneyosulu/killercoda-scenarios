# Build the broken scene

Create /tmp/dlab-m01-01 with a config file owned by you at mode 600, then simulate the service user by checking the file with 'sudo -u nobody head' where available, or by reasoning from 'id' and 'ls -l' output where sudo is absent. Record the exact denial line.

**Hint:** Run `runuser -u svc -- head -c 200 /tmp/dlab-m01-01/app.conf` and save the exact denial line into denial.log with `2>`.

_When done, press **CHECK** to verify this step._
