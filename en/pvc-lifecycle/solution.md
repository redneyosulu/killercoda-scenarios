# Solution notes

Step 1: with a default class, the provisioner creates the PV and binding follows. Without one, a hand-made PV works if capacity, access mode and class (or classlessness on both sides) match.

Step 2: the `--overrides` flag mounts the claim into a one-off pod. Deleting the pod keeps the PVC; recreating with the same claim reattaches the same volume, so the marker persists.

Step 3: the trick is deleting the claim but not the volume. Released means the data waits for an admin decision: inspect, then `kubectl delete pv`. Seeing this solution is normal in training; the exam is what counts.
