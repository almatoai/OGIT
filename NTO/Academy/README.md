# Academy

NTO for the Bardioc Academy: courses and their dependencies, learner enrollment and
progress, ratings, the catalogue and its tracks, and verifiable certificates. The
Bardioc graph is the source of truth; Area9 is the LMS.

## New entity (entities/)

- **Enrollment** -- reified learner<->course state: `enrollmentStatus`, `lastVerb`,
  `registrationId`, `progress`, xAPI Result fields, `resumeLocation`, lifecycle
  timestamps, per-course licence window. Reified because OGIT edges carry no attributes
  (cf. `ogit:Rating`). Canonical learner edge: `ogit.Auth:Account -has-> Enrollment`.

## New verbs (verbs/)

`enrolledIn` (Enrollment->Course), `resultedIn` (Enrollment->Certificate), `certifies`
(Certificate->Course), `supersedes` (Course->Course, version/re-training). No Academy
edge uses the generic `ogit:relates`.

## New attributes (attributes/) -- 45, namespace `ogit.Academy`

- **Course:** achievementId, activityId, courseCode, criteria, criteriaId, courseMode,
  passingScore, educationalLevel, timeRequired, moveOn, launchUrl, promoted,
  prerequisiteSummary.
- **Certificate:** credentialId, credentialType, credentialContext, proofValue,
  securingMechanism, proofCryptosuite, joseAlgorithm, proofVerificationMethod,
  proofPurpose, proofCreatedAt, credentialStatus, verificationUrl.
- **Enrollment:** enrollmentStatus, lastVerb, registrationId, progress, completion,
  success, scoreScaled/Raw/Min/Max, sessionDuration, resumeLocation, enrolledAt,
  startedAt, completedAt, lastActivityAt, licenseIssuedAt, licenseExpiresAt.
- **Account:** lmsActivatedAt, lmsActiveUntil.

## Reused types / verbs

Types: `ogit:Course`, `ogit:Certificate`, `ogit:Catalog`, `ogit:Rating`,
`ogit:Attachment`, `ogit.Documents:Document`, `ogit:Person`, `ogit:Organization`,
`ogit.Auth:Account`, `ogit.ClassificationStandard:ClassificationStandardTreeBranch`
(tracks), `ogit.HR.Recruiting:Skill` (prior knowledge), `ogit.Forum:Award` (badges).
Verbs: `requires`, `precedes` (one direction; follows derived), `contains`, `rates`,
`provides`, `receives`, `creates`, `has`, `classifiedUnder`.

## Extensions to existing core types (additions only)

These types gain allowed-edge entries (and Course/Certificate/Account a few optional
attributes) to wire in the Academy types; see the diff for the exact lines:
`ogit:Course`, `ogit:Certificate`, `ogit:Person`, `ogit:Catalog`, `ogit:Organization`,
`ogit:Rating`, `ogit.Auth:Account`.

## Modelling notes

- **IRIs:** `ogit:id` is the internal node id (UUID). The standards' HTTP IRIs use
  dedicated attributes: `achievementId` (OB Achievement.id), `credentialId`
  (VC/OB credential id), `activityId` (xAPI Activity id / cmi5 grouping).
- **Account is the canonical learner anchor:** `has -> Enrollment` and `lmsActivatedAt`/
  `lmsActiveUntil` are on the Account only; Person only `receives -> Certificate/Award`.
- **`promoted`** is a phase-1, course-global flag (per-catalogue promotion is phase-2).
- **"available"** is derived (no Enrollment / NotStarted), not an enum value.
- **Certificate signing:** the signed VC/JWS/PDF lives in an `Attachment`; the `proof*`
  attributes are a queryable cache (embedded Data Integrity case) -- for enveloping
  (JOSE/SD-JWT/COSE) only the Attachment is authoritative.

## Standards alignment

Modelled to align with **Open Badges 3.0 / W3C Verifiable Credentials 2.0** (certificates),
**xAPI (IEEE 9274.1.1-2023) + cmi5** (learning records, aggregate state in phase 1) and
**schema.org Course** (catalogue). The VC `credentialSubject` and `issuer` and the
JSON-LD type strings are reconstructed at export from the graph, not stored verbatim.

## Application-layer enforcement

A few standard-mandatory fields cannot be enforced on the shared SGO core types
(`ogit:Course`, `ogit:Certificate`), so the Academy service enforces them on write:

| Field | OGIT slot | Rule |
| --- | --- | --- |
| Achievement.criteria, .description, .id | criteria / `ogit:description` / achievementId | reject Academy course without them |
| xAPI Activity id | activityId | reject Academy course without it |
| Credential id, validFrom | credentialId / `ogit:validFrom` | set/require at issuance |
| issuer id | Organization `ogit:webPage` | require a resolvable IRI at issuance |
| cmi5 registration | registrationId | require once the enrollment is past NotStarted |
| score / progress ranges | -- | range-check (no native validator) |
