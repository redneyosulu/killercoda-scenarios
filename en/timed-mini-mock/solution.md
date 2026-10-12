# Solution notes

Fault 1: `kubectl -n mock-run rollout undo deployment/app-b`, then wait for Running pods. Fault 2: patch the selector back to `app: app-a` (the label `kubectl expose` set), endpoints refill. Fault 3: `kubectl -n mock-run rollout resume deployment/app-a`.

Review example block: `fault: dead selector / domain: networking / class: method / drill: endpoints-first card on five services`. Seeing this solution is normal in training; the exam is what counts.
