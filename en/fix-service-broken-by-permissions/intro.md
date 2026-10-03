# Fix the Service That Permissions Broke

**Environment.** Ubuntu 24.04, About 40 minutes.

## What you will do

- Reproduce a permission-denied service failure from the service user's side
- Name the process user and the file owner before changing anything
- Repair with the narrowest mode that works and prove it as the service user

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
