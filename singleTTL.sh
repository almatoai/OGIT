#!/bin/sh

TTLFILE=graphit-ontology.ttl
rm -f $TTLFILE


find . -type f -name '*.ttl' -exec cat {} \; -exec echo $'\n' \;> TMP_cat_all.txt
grep "@prefix" TMP_cat_all.txt | awk '{$1=$1}!A[toupper($0)]++' > TMP_prefixed.txt
grep -v "@prefix" TMP_cat_all.txt > TMP_no_prefixes.txt
cat TMP_prefixed.txt TMP_no_prefixes.txt > $TTLFILE
rm TMP_prefixed.txt TMP_no_prefixes.txt TMP_cat_all.txt
echo $TTLFILE 'has been generated.'
