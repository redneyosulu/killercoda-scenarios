# Build the CA and the flawed fixtures

Generate a test CA, then issue three server certificates: one expired (short -days with backdated start, or an already-lapsed fixture), one with a SAN for the wrong name, and one correct leaf whose chain file omits the intermediate. Keep the CA certificate separate and labeled TEST ONLY.

**Hint:** Serve each fixture with openssl s_server on 18441 (good), 18442 (wrong SAN), 18443 (leaf only, no chain). Diagnose each with s_client -CAfile test-ca.crt and write diagnosis.txt quoting all three flaw lines.

_When done, press **CHECK** to verify this step._
