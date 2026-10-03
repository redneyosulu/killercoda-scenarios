# Separate a Wrong DNS Record from a Wrong App Port

**Environment.** Ubuntu 24.04, About 40 minutes.

## What you will do

- Reproduce a failure with two simultaneous faults: a wrong name and a wrong port
- Prove which layer is guilty with getent versus dig before touching either
- Fix the name layer first, then test the port exactly once

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
