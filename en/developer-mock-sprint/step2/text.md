# Run it capped

With the board staged, finish the app under caps: wire the configmap via envFrom and the secret key as an env var (regenerate or edit plus apply), fit a startupProbe plus livenessProbe, and confirm the service has endpoints. Debugging stalls get the two-minute flag rule; authoring stalls get eight minutes, then flag.

Verify with dry-run before every apply, and close with the sweep: pods ready, answers match, nothing re-applied. CHECK verifies probes in spec plus live endpoints.
