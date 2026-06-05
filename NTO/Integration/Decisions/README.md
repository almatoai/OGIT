# Integration / Decisions

## Overview

This sub-namespace collects the decision-and-lifecycle vertices that the Bardioc Connector Framework produces during connector operation: manual-review queue entries (`IdentityCandidate`, `IdentityCandidateOption`), merge and split workflows (`MergeJob`, `SplitJob`), conflict-resolution awaiters (`Conflict`), transient source-side events (`UserAction`), Data Subject Rights workflows (`SubjectRequest`), value and schema drift candidates (`ValueDriftCandidate`, `SchemaDriftCandidate`), and action invocations (`ActionInvocation`).

Right-to-Erasure under GDPR Article 17 has a bounded target by traversing this sub-namespace alone. Parent `NTO/Integration/` and OGIT base entities are not touched by RtE sweeps.

## Source documents

- Bardioc Connector Framework 2.0 OGIT Extensions Section 3.2 (Phase B Doc 1)
- Bardioc Connector Framework 2.0 Multi-Source Identity Sections 6 / 7 / 14.3 (Phase A)

## Conventions

- Vertices in this sub-namespace carry PII directly or are per-Subject decision records. Audit records that must survive RtE (per PLAN D18 audit-forever) live elsewhere.
- All entities, attributes and verbs use `dcterms:creator "Almato AG"`.
- Boolean and enum attributes carry `ogit:validation-type "fixed"` plus `ogit:validation-parameter "<csv>"`.
