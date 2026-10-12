# Solution notes

Step 1: `/bin/false` exits immediately, so the kubelet restarts it in a BackOff loop. Describe shows the restart count rising; `--previous` logs are empty because false prints nothing: that emptiness is itself the verdict (bad command, nothing to read). Recreate with `sleep 3600`.

Step 2: `kubectl create deployment shop` labels pods `app=shop`. A Service selecting `app=shop-wrong` yields empty endpoints: fix the selector, endpoints fill, curl answers.

Step 3: same two fixes, timed. Most learners find the second round twice as fast: the method replaced the search. Seeing this solution is normal in training; the exam is what counts.
