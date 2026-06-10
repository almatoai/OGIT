# Integration / Decisions / Audit

## Overview

This sub-namespace collects audit-and-evidence records that MUST
survive Right-to-Erasure per PLAN D18 (audit-forever). Vertices
here reference subjects only by stable pseudonymous identifiers
that survive RtE; they carry no raw PII.

Entities: ActionInvocation, ValueDriftCandidate, SchemaDriftCandidate.

## Conventions

- All entities, attributes and verbs use `dcterms:creator "Almato AG"`.
- Right-to-Erasure operations MUST NOT touch this namespace.
- If a record in this namespace carries information derived from
  a Subject's PII (e.g. SchemaDriftCandidate.unrecognised_payload,
  sourceId when used here), the platform MUST pseudonymise
  before persistence -- the audit-forever guarantee is on the
  structural record, not on raw source content.

## Audit-forever applies to streams, not necessarily to vertices

ActionInvocation (per PLAN D34) is an ephemeral vertex with a
`vertexTtlDays` policy: after the action's terminal state, the
vertex is hard-deleted to limit warm-tier size. The
audit-forever invariant applies to the TSDB lifecycle and
16-field-audit streams (PLAN D28 / D30a), which outlive the
vertex. Vertex hard-deletion here is operational housekeeping,
not a Right-to-Erasure event.
