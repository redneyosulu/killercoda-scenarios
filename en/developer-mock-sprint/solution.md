# Solution notes

Step 1: three dry-run generations to files, one apply each, one expose. Caps written before any apply: authoring eight minutes, debugging two.

Step 2: add `envFrom: [{configMapRef: {name: app-cfg}}]` plus `env: [{name: API_TOKEN, valueFrom: {secretKeyRef: {name: api-sec, key: token}}}]`, startupProbe covering the pull plus livenessProbe, apply with dry-run first. Endpoints prove selection; describe proves probes.

Step 3: example block: `stall: probe fit / pole: model / drill: recite handler-effect-shape then apply once`. Seeing this solution is normal in training; the exam is what counts.
