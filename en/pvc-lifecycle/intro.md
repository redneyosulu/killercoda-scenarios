# PVC lifecycle

Pods are cattle; data is not. In this scenario you provision a volume through a claim, prove a file survives the pod that wrote it, then deliberately create a retained volume and watch it outlive its claim.

If this environment has no StorageClass, step 1 shows the manual-PV fallback: the binding lesson is identical either way.
