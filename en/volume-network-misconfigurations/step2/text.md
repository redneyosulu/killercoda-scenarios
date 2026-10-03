# Fix both layers

Attach both services to a named network, move database data to a named volume, and remove published ports that only serve container-to-container traffic. Recreate both containers.

**Hint:** Write compose.yaml: one shared user-defined network, db data on a named volume, NO published db port. Recreate both containers and show both Up.

_When done, press **CHECK** to verify this step._
