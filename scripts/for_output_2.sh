#!/bin/bash

src_dir="output_1"
dest_dir="output_2"

# Create the destination folder if it doesn't exist
mkdir -p "$dest_dir"

# Find and copy raw CSV files
find "$src_dir" -type f -name "*_raw.csv" | while read filepath; do
  # Extract the filename and parent folder for renaming
  parent_dir=$(basename "$(dirname "$filepath")")
  filename=$(basename "$filepath")
  
  # Construct a new filename to avoid overwriting
  new_filename="${parent_dir}_${filename}"

  # Copy and rename the file to the destination
  cp "$filepath" "$dest_dir/$new_filename"
done

echo "✅ All *_raw.csv files copied and renamed into '$dest_dir'."

