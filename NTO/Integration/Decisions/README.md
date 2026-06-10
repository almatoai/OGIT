# Integration / Decisions

## Overview

This sub-namespace collects the decision-and-lifecycle vertices that the Bardioc Connector Framework produces during connector operation. It is **split into two sub-children** with disjoint Right-to-Erasure semantics:

- **`Decisions/PII/`** (seven entities) -- the Right-to-Erasure target under GDPR Article 17. Entities here carry PII directly or are per-Subject decision records. Manual-review queue entries (`IdentityCandidate`, `IdentityCandidateOption`), merge and split workflows (`MergeJob`, `SplitJob`), conflict-resolution awaiters (`Conflict`), transient source-side events (`UserAction`), Data Subject Rights workflows (`SubjectRequest`).
- **`Decisions/Audit/`** (three entities) -- audit-namespace records that **MUST NOT be touched by RtE** per PLAN D18. Value and schema drift candidates (`ValueDriftCandidate`, `SchemaDriftCandidate`) and action invocations (`ActionInvocation`). The audit-forever invariant applies to the TSDB streams keyed by these vertices, not necessarily to the vertices themselves -- `ActionInvocation` is ephemeral with a `vertexTtlDays` hard-delete after closure; the TSDB lifecycle and 16-field-audit streams (PLAN D28 / D30a) survive.

**Right-to-Erasure rule.** RtE sweeps target `Decisions/PII/` only. Implementations that operate on this namespace MUST verify the sub-namespace before delete. A DPO executor traversing `Decisions/` indiscriminately would violate D18 audit-forever; the schema split makes the correct target unambiguous.

**Audit-forever applies to streams, not necessarily to vertices.** ActionInvocation (per PLAN D34) is an ephemeral vertex with a `vertexTtlDays` policy: after the action's terminal state, the vertex is hard-deleted to limit warm-tier size. The audit-forever invariant applies to the TSDB lifecycle and 16-field-audit streams (PLAN D28 / D30a) which outlive the vertex. Vertex hard-deletion is operational housekeeping, not a Right-to-Erasure event.

## Source documents

- Bardioc Connector Framework 2.0 OGIT Extensions Section 3.2 (Phase B Doc 1)
- Bardioc Connector Framework 2.0 Multi-Source Identity Sections 6 / 7 / 14.3 (Phase A)

## Conventions

- Vertices in `Decisions/PII/` carry PII directly or are per-Subject decision records.
- Vertices in `Decisions/Audit/` reference subjects only by stable pseudonymous identifiers that survive RtE; raw PII fields (e.g. `sourceId`, `unrecognisedPayload`) MUST be pseudonymised at ingest.
- All entities, attributes and verbs use `dcterms:creator "Almato AG"`.
- Boolean and enum attributes carry `ogit:validation-type "fixed"` plus `ogit:validation-parameter "<csv>"`.
