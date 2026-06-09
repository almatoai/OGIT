# Integration

## Overview

This NTO defines the schema additions the Bardioc Connector Framework needs to operate as a first-class platform layer: connector blueprints and their deployment-time instances, the immutable run history, the mapping / netting / conflict / weaving / action rule entities, the authority chain, and the multi-team governance signatures.

The PII-bearing decision-and-lifecycle vertices (manual-review queue entries, merge jobs, conflicts, transient user actions, DSR requests, drift candidates, action invocations) live in the sibling sub-namespace `NTO/Integration/Decisions/`. Right-to-erasure has a bounded target by traversing `Decisions/PII/` alone; this namespace itself is structural and PII-free.

## Source documents

- Bardioc Connector Framework 2.0 OGIT Extensions (Phase B Doc 1)
- Bardioc Connector Framework 2.0 Multi-Source Identity (Phase A)
- Bardioc Connector Framework 2.0 Netting (Phase A)
- Bardioc Connector Framework 2.0 Overview (Phase A)
- Bardioc Connector Framework 2.0 Four-Modes (Phase A)

## Conventions

- All entities, attributes and verbs use `dcterms:creator "Almato AG"` per the arago-Almato merger discipline.
- Boolean and enum attributes carry `ogit:validation-type "fixed"` plus `ogit:validation-parameter "<csv>"`. Open-ended descriptions (ending in "... etc.") deliberately omit the fixed parameter.
- Edge targets in `ogit:allowed` always name concrete vertex types. OGIT has no edge inheritance and no any-vertex edge target: every allowed edge must be declared explicitly between concrete types. Where the framework must reference an entity of arbitrary type -- a ConflictLock's locked vertex, a Conflict's affected vertex -- it uses a soft `*_xid` attribute reference (`target_xid`, `affected_entity_xid`) instead of an edge. Neither `ogit:Node` nor `ogit:Entity` is used as an edge target.
- The framework adds; it never alters existing OGIT entities.
