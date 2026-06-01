#!/usr/bin/env bash
# Validate the OGIT ontology in a SINGLE Java invocation.
#
# Background
# ----------
# The previous one-liner `find ... | xargs java -jar bin/ogit-validator.jar`
# silently produced phantom errors as soon as the repository grew past
# the per-invocation argument-list limit of GNU `xargs` (~128 KB on the
# CI's Linux defaults, derived from POSIX ARG_MAX). When the joined
# argument string exceeds that limit, `xargs` splits the call into two
# or more separate Java invocations, each of which sees only a subset
# of the .ttl files and therefore cannot resolve cross-references
# whose target definition lives in the other subset. The CI log of
# such a run prints two `Count of errors:` summary blocks (e.g. 2943
# and 312) full of "doesn't exist!" errors against ogit:name,
# ogit:Node, ogit:generates, ogit:Timeseries, ogit:Location etc. --
# all of which are correctly defined in SGO/sgo/.
#
# Note: passing the repo root as a directory argument
# (`java -jar bin/ogit-validator.jar .`) is NOT a usable fix even
# though the validator's --help advertises directory recursion.
# That call path returns "Validation successful." without actually
# discovering the .ttl files under the directory (verified on
# OpenJDK 21 against this repo).
#
# Fix
# ---
# We expand the file list inline with xargs and force the per-call
# byte budget to a value above any plausible OGIT repository size,
# so xargs runs the validator in exactly ONE invocation. The
# xargs `-s` flag's maximum is bounded by the kernel's ARG_MAX
# (typically 2 MB on modern Linux). We pick 1900000 (1.9 MB) so we
# stay safely below ARG_MAX while still accommodating well over
# 30000 .ttl files at average path lengths. The repository as of
# this commit holds ~1850 .ttl files (joined argument string ~70
# KB) and is expected to grow to ~3000 with the NTO/Utilities PR
# (~158 KB) -- both fit in a single invocation under this budget.
#
# Instrumentation
# ---------------
# Before invoking the validator we print the file count and joined
# argument-string size so the CI log shows exactly what was passed.
# The validator's own `Count of errors:` / `Count of warnings:`
# summary lines should appear EXACTLY ONCE in the log if the budget
# fits; if they appear more than once, the `-s` value needs to be
# raised further (which would also mean we are approaching ARG_MAX
# and need a different strategy).
set -euo pipefail

files=$(find . -type f ! -name 'graphit-ontology.*' -name "*.ttl")
nfiles=$(printf '%s\n' "$files" | wc -l)
nbytes=$(printf '%s' "$files" | wc -c)
echo "validate.sh: $nfiles TTL files, $nbytes bytes of paths"

printf '%s\n' "$files" | xargs --no-run-if-empty -s 1900000 java -jar bin/ogit-validator.jar
