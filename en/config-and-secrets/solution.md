# Solution notes

Step 1: pod spec needs `env: [{name: MODE, valueFrom: {configMapKeyRef: {name: app-literal, key: MODE}}}]` plus a volume `{name: greet, configMap: {name: app-file}}` mounted at `/etc/greeting`. Imperative shortcut: `kubectl run` cannot express both, so write this pod as YAML (generated skeleton plus edits: the one place hand-editing pays).

Step 2: same shape with `secretKeyRef: {name: db-pass, key: password}`. `test -n` proves presence with exit code only. Seeing this solution is normal in training; the exam is what counts.
