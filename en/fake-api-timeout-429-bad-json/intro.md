# Handle Timeout, 429 and Bad JSON Against a Fake API

**Environment.** Ubuntu 24.04, About 50 minutes.

## What you will do

- Serve the three bad behaviors locally: hangs, rate limits, malformed bodies
- Handle each with timeouts, bounded retry and parsed responses
- Cover every bad input with a test; use no real credentials

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
