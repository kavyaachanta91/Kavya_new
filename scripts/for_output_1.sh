#!/bin/bash

# Define the file containing the GSE accession IDs
input_file="prostate_gse_accs.txt"

# Define the output directory for metadata
output_dir="output_1"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through each GSE accession in the file
while IFS= read -r gse_acc; do
  # Trim leading and trailing spaces from the accession ID
  gse_acc=$(echo "$gse_acc" | xargs)

  echo "Fetching metadata for $gse_acc..."

  # Run geofetch with --just-metadata for each GSE accession
  geofetch -i "$gse_acc" -m "$output_dir/$gse_acc" --just-metadata

done < "$input_file"

# Notify the user when done
echo "Metadata fetching complete. Check the '$output_dir' directory for results."

