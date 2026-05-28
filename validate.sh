#!/usr/bin/env bash
# Validate the OGIT ontology.
#
# The validator accepts <file|directory>... arguments and recurses
# into directories on its own (see `java -jar bin/ogit-validator.jar --help`).
# We pass the repo root as a single directory argument so the
# validator runs as ONE Java invocation. This avoids the previous
# `find ... | xargs java -jar ...` form, which splits the file list
# into multiple Java invocations once the argument-string length
# exceeds the system's per-invocation limit (~128 KB on Linux ARG_MAX
# defaults; reached as soon as the repository has more than roughly
# 2500-3000 .ttl files). Each split Java invocation only sees a
# subset of the .ttl files, so any TTL it parses that references a
# class / attribute / verb defined in a file in the *other* subset
# fails cross-reference resolution and prints
#     "ERROR: ... doesn't exist!"
# even though the referenced entry is correctly defined elsewhere
# in the repository. Single-invocation directory argument fixes this
# deterministically and is the form documented in the validator's
# own `--help` example.
set -e
java -jar bin/ogit-validator.jar .
