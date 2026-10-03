# Inspect TLS Failures with a Test CA and Fixture Certificates

**Environment.** Ubuntu 24.04, About 50 minutes.

## What you will do

- Create a test CA and issue fixture certificates with one deliberate flaw each
- Diagnose an expired certificate, a wrong hostname and a missing intermediate from the command line
- Verify with explicit trust instead of disabling verification

_Wait until the terminal prints `Environment ready` before step 1. Setup runs in the background._
