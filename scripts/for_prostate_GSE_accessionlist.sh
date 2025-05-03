#!/bin/bash

# Output files
output_file="prostate_gse_accs.txt"
error_file="geo_query_errors.log"

# Clear previous output
> "$output_file"
> "$error_file"

# GEO query
geo_query='(("prostatic neoplasms"[MeSH Terms] OR "prostate cancer"[All Fields]) AND "Homo sapiens"[Organism]) AND ("expression profiling"[All Fields]) AND "tissue"[All Fields] NOT "cell line"[All Fields]'

# Run query, extract GSE accessions using awk
{
  esearch -db gds -query "$geo_query" \
    | efetch -format docsum \
    | awk '/<Accession>/ && /GSE/ { gsub(/<\/?Accession>/, "", $0); print $0 }' \
    > "$output_file"
} 2>> "$error_file"

# Status
if [ -s "$output_file" ]; then
  echo "✅ GSE accession list saved to: $output_file"
else
  echo "⚠️ No accessions found. Check $error_file for details."
fi

