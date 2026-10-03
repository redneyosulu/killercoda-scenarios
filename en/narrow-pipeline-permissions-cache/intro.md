# Fix Over-wide Pipeline Permissions and a Wrong Cache Key

**Environment.** Ubuntu 24.04, About 50 minutes.

## What you will do

- Scope each job to the minimum permission its steps need
- Repair a cache key so wrong-branch restores fail closed
- Prove a denial: the narrowed job cannot reach what it no longer needs

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
