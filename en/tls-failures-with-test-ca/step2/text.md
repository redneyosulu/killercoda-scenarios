# Diagnose each flaw

Serve each fixture with openssl s_server on a different local port and run s_client with -CAfile pointing at the test CA. Record the verify return code and the line that names the flaw for all three cases.

**Hint:** Assemble fullchain.pem (leaf-good + intermediate) and serve it on 18445 with -build_chain -chainCAfile test-ca-full.crt (modern s_server sends only the leaf otherwise). Verify return code 0 with -CAfile, save the line into fixed.txt. Never use --insecure or verification bypasses.

_When done, press **CHECK** to verify this step._
