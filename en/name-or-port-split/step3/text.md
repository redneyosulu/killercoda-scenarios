# Repair in layer order

Remove the hosts pin, confirm both resolution tools agree on 127.0.0.1, then correct the port and show one successful request. Record the check order: resolver split first, port test second.

**Hint:** Point the pin at 127.0.0.1 (edit /etc/hosts, do not just delete), confirm getent and python agree, then one clean curl to svc-lab.test:18080.

_When done, press **CHECK** to verify this step._
