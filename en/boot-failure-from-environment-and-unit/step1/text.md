# Plant two faults

Take a minimal unit (or a start script) that runs 'APP_PORT=8080 myapp'. Introduce fault A: an env file setting APP_PORT to a word instead of a number. Introduce fault B: a unit pointing ExecStart at a renamed binary path. Keep both written down separately.

**Hint:** Open myapp.unit and app.env, then write faults.txt with fault A (bad value) and fault B (wrong binary path) before you boot anything.

_When done, press **CHECK** to verify this step._
