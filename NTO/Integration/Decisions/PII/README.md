# Integration / Decisions / PII

## Overview

This sub-namespace collects the PII-bearing decision-and-lifecycle
vertices that the Bardioc Connector Framework produces. Right-to-
Erasure under GDPR Article 17 has a bounded target by traversing
this sub-namespace.

Entities: IdentityCandidate, IdentityCandidateOption, MergeJob,
SplitJob, Conflict, UserAction, SubjectRequest.

## Conventions

- All entities, attributes and verbs use `dcterms:creator "Almato AG"`.
- The platform's DPO executor (Identity v2 Section 14.3) scopes
  every Right-to-Erasure execution to this namespace plus the
  source-side attribute writes recorded in TSDB.
