# Integration / Decisions / Audit

## Overview

Audit-and-evidence records that MUST survive Right-to-Erasure. Vertices here
reference subjects only by stable pseudonymous identifiers that survive erasure;
they carry no raw PII.

Entities: ActionInvocation, ValueDriftCandidate, SchemaDriftCandidate.

- Right-to-Erasure operations MUST NOT touch this namespace.
- A record derived from a Subject's PII (e.g. a drift candidate's unrecognised
  payload, or a source id) MUST be pseudonymised before persistence -- the
  survive-erasure guarantee is on the structural record, not on raw source
  content.

**Audit-forever applies to streams, not vertices.** ActionInvocation is
ephemeral (hard-deleted after its terminal state); the audit guarantee is on the
timeseries / audit streams keyed by it, which outlive the vertex. Vertex
hard-deletion is housekeeping, not a Right-to-Erasure event.
