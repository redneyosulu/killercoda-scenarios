# Lay the stages in cost order

Write a pipeline with checkout, lint plus unit tests, build, and a package step that only runs on green. Keep the blocking path under ten minutes and record each stage duration.

**Hint:** Write pipeline.sh (checkout, lint, unit, build, package; each stage timed, downstream SKIPs on red) and run it green. Extract the timed stage lines into stages.txt.

_When done, press **CHECK** to verify this step._
