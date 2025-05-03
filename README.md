# Kavya_new

# NCBI GEO Search Pipeline – Prostate Cancer Expression Data

This repository contains a workflow to query, retrieve, filter, and summarize prostate cancer-related gene expression data from the NCBI GEO database.

---

# GEO Search and Accession List

- The GEO query is defined in `for_prostate_GSE_accessionlist.sh`:
  ```bash
  geo_query='(("prostatic neoplasms"[MeSH Terms] OR "prostate cancer"[All Fields]) AND "Homo sapiens"[Organism]) AND ("expression profiling"[All Fields]) AND "tissue"[All Fields] NOT "cell line"[All Fields]'

The resulting GSE accession list is saved for further analysis.

# Metadata and Raw Data Retrieval
for_output_1.sh
→ Retrieves metadata for each GSE ID in the list.

for_output_2.sh
→ Downloads raw .csv expression data files and saves them into the output_2/ folder as PEP_raw.csv.

# Data Filtering Pipeline
1.Column Selection

for_output_3.R
→ Filters and keeps only required columns from the raw data in output_2/.
➡️ Output: output_3/

2.Sample Filtering

for_output_4_prostate.R
→ Retains only "total RNA" samples
→ Removes "gDNA" samples and irrelevant entries
➡️ Output: output_4/

3.Sample Summarization

for_output_5.R
→ Counts total samples and summarizes each column
➡️ Output: output_5/

# Data Integration and Final Metadata
for_combined_data.R
→ Combines all cleaned files in output_5/ using cbind

for_final_metadata.R
→ Uses GEOquery to fetch dataset title, summary, and overall design
→ Final result saved as final_metadata.csv

#Project Structure
Kavya_new/
├── output_2/            # Raw downloaded expression data (PEP_raw.csv)
├── output_3/            # Filtered columns
├── output_4/            # Filtered for "total RNA" samples
├── output_5/            # Summary and sample counts
├── scripts/             # All .sh and .R scripts
├── final_metadata.csv   # Final combined and annotated metadata
├── README.md            # Project documentation