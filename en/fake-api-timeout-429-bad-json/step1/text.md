# Build the misbehaving API

Serve four endpoints locally: /ok (valid JSON), /slow (sleeps 30s), /limited (first two hits 429 with Retry-After, then ok), /broken (200 with truncated JSON). Nothing leaves localhost.

**Hint:** Prove all four endpoints live on localhost: curl /ok /slow (with max-time), /limited three times, /broken. Save the four status codes into endpoints.txt.

_When done, press **CHECK** to verify this step._
