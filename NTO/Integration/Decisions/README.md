# Integration / Decisions

## Overview

Decision-and-lifecycle vertices the Connector Framework produces during
operation, split into two sub-children with disjoint Right-to-Erasure semantics:

- `Decisions/PII/` (seven entities) -- the Right-to-Erasure target (GDPR
  Art. 17). Entities carry PII directly or are per-Subject decision records:
  manual-review entries (IdentityCandidate, IdentityCandidateOption), merge and
  split workflows (MergeJob, SplitJob), conflict awaiters (Conflict), transient
  source events (UserAction), Data-Subject-Rights workflows (SubjectRequest).
- `Decisions/Audit/` (three entities) -- audit records that MUST survive
  Right-to-Erasure: ValueDriftCandidate, SchemaDriftCandidate, ActionInvocation.

**Right-to-Erasure rule.** RtE sweeps target `Decisions/PII/` only; an executor
traversing `Decisions/` indiscriminately would erase audit records.
Implementations MUST check the sub-namespace before delete.

**Audit-forever applies to streams, not vertices.** ActionInvocation is an
ephemeral vertex (hard-deleted after its terminal state to bound warm-tier
size); the audit guarantee is on the timeseries / audit streams keyed by it,
which outlive the vertex. Vertex hard-deletion is housekeeping, not a
Right-to-Erasure event.
