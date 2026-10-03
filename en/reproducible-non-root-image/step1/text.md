# Ship the naive image first

Build a single-stage image as root with unpinned base and app copied before dependencies. Record image size and a full rebuild time.

**Hint:** Copy ctx/ to naive/, write a single-stage Dockerfile (unpinned python:3 base, COPY all before pip install, root default), build, record size plus full build seconds in naive.txt, run once and record the in-container UID.

_When done, press **CHECK** to verify this step._
