# Integration / Decisions / PII

## Overview

The PII-bearing decision-and-lifecycle vertices the Connector Framework
produces. Right-to-Erasure (GDPR Art. 17) has a bounded target by traversing
this sub-namespace.

Entities: IdentityCandidate, IdentityCandidateOption, MergeJob, SplitJob,
Conflict, UserAction, SubjectRequest.

The platform's Right-to-Erasure executor scopes every erasure to this namespace
plus the source-side attribute writes recorded in the timeseries store.
