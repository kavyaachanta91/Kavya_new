#!/bin/bash

#create .here file to define project root (optional but recommended)
touch /Users/kachanta/Desktop/Kavya_new/scripts .here

# Set working directory
cd /Users/kachanta/Desktop/Kavya_new/scripts

# Step 1: Run shell scripts
bash for_prostate_GSE_accessionlist.sh
bash for_output_1.sh
bash for_output_2.sh

# Step 2: Run R scripts
Rscript for_output_3.R
Rscript for_output_4.R
Rscript for_output_5.R
Rscript for_combined_data.R
Rscript for_final_metadata.R

echo "✅ Pipeline complete. Final output: final_metadata.csv"

