# Fix the Shell Script That Spaced Filenames Break

**Environment.** Ubuntu 24.04, About 40 minutes.

## What you will do

- Reproduce a word-splitting failure with spaced filenames
- Repair with quoting, globs and set -euo pipefail
- Prove the repair with a failing-then-passing test plus a clean ShellCheck run

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
