
# Kavya_new

## NCBI GEO Search Pipeline – Prostate Cancer Expression Data

This project provides a comprehensive workflow to query, retrieve, filter, and summarize prostate cancer-related gene expression datasets from the NCBI GEO database. It is designed to facilitate reproducible data collection and preprocessing for downstream analyses.

### Project Overview

The pipeline automates the process of:

- Searching GEO for relevant prostate cancer expression datasets
- Downloading raw and metadata files
- Filtering and cleaning sample data
- Summarizing sample counts and metadata
- Integrating dataset annotations for enriched metadata

### Workflow and File Structure

1. **GEO Search and Accession List**

Script: `scripts/for_prostate_GSE_accessionlist.sh`

Description: Queries NCBI GEO for prostate cancer datasets in human tissues (excluding cell lines) with expression profiling.

Output: List of GSE accession IDs for further processing.

```bash
geo_query='(("prostatic neoplasms"[MeSH Terms] OR "prostate cancer"[All Fields]) AND "Homo sapiens"[Organism]) AND ("expression profiling"[All Fields]) AND "tissue"[All Fields] NOT "cell line"[All Fields]'
```

2. **Metadata and Raw Data Retrieval**

Scripts:

- `scripts/for_output_1.sh` — Retrieves metadata for each GSE ID.
- `scripts/for_output_2.sh` — Downloads raw CSV expression data files saved in `output_2/` as `PEP_raw.csv`.

3. **Data Filtering Pipeline**

| Step              | Script                     | Description                                                              | Output Folder |
|-------------------|----------------------------|--------------------------------------------------------------------------|---------------|
| Column Selection  | `scripts/for_output_3.R`    | Selects and retains only required columns from raw data.                 | `output_3/`   |
| Sample Filtering  | `scripts/for_output_4_prostate.R` | Filters for "total RNA" samples, removes gDNA and irrelevant samples. | `output_4/`   |
| Sample Summarization | `scripts/for_output_5.R`   | Counts total samples and summarizes unique values per column.            | `output_5/`   |

4. **Data Integration and Final Metadata**

Scripts:

- `scripts/for_combined_data.R` — Combines all cleaned files from `output_5/` into a single dataset.
- `scripts/for_final_metadata.R` — Uses GEOquery to fetch dataset titles, summaries, and designs; merges with summarized data.

Final Output: `final_metadata.csv`

### Project Directory Structure

```bash
Kavya_new/
├── output_2/            # Raw downloaded expression data (PEP_raw.csv)
├── output_3/            # Filtered columns
├── output_4/            # Filtered for "total RNA" samples
├── output_5/            # Summary and sample counts
├── scripts/             # All shell (.sh) and R (.R) scripts
├── final_metadata.csv   # Final combined and annotated metadata
├── README.md            # Project documentation
```
