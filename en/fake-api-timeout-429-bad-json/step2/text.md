# Write the hardened client

Write a fetch-and-gate script with connect/total timeouts, max 3 attempts with backoff, 429 honored via Retry-After, and jq -e parsing with defaults. Every constant (attempts, sleeps, budget) visible at the top.

**Hint:** Write fetch.sh <path>: TIMEOUT, MAX_ATTEMPTS, BACKOFF constants on top; curl connect/total timeouts; max 3 attempts; honor Retry-After on 429; jq -e parse; clean nonzero exit on bad JSON.

_When done, press **CHECK** to verify this step._
