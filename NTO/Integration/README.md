# Integration

## Overview

The schema additions the Bardioc Connector Framework needs to operate as a
platform layer: connector blueprints and their deployment-time instances, the
immutable run history, the mapping / netting / conflict / weaving / action rule
entities, the authority chain, and the multi-team governance signatures.

Although developed for the Bardioc Connector Framework 2.0, these entities are
modelled to stand on their own: a general semantic vocabulary for data
integration -- the path from a source, through mapping, netting and conflict
resolution, to a governed, provenance-tracked write. The intent is a shared OGIT
understanding of data-integration paths, not only the backing schema for one
framework's implementation.

The PII-bearing decision-and-lifecycle vertices (manual-review entries, merge
and split jobs, conflicts, transient user actions, DSR requests, drift
candidates, action invocations) live in `Decisions/`. This namespace itself is
structural and PII-free; Right-to-Erasure targets `Decisions/PII/` alone.

Conventions common to every OGIT namespace (creator, fixed value sets, edge
targets, additive-only) are in the repository root README.
