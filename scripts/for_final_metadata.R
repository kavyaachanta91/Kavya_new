library(GEOquery)
library(dplyr)
library(here)

# Step 1: Read your original metadata file using here()
metadata_file <- here("combined_data.csv")
metadata <- read.csv(metadata_file, stringsAsFactors = FALSE)

# Step 2: Extract unique GEO series IDs
geo_ids <- unique(metadata$unique_sample_series_id)  # Ensure this column name is correct

# Step 3: Use GEOquery to fetch metadata for each GSE
geo_info <- lapply(geo_ids, function(geo_id) {
  tryCatch({
    message("Fetching: ", geo_id)
    gse <- getGEO(geo_id, GSEMatrix = FALSE)
    
    # Safely extract and collapse metadata fields
    title <- paste(Meta(gse)$title, collapse = " ")
    design <- paste(Meta(gse)$overall_design, collapse = " ")
    summary <- paste(Meta(gse)$summary, collapse = " ")
    
    list(
      GEO_ID = geo_id,
      title = title,
      overall_design = design,
      summary = summary
    )
  }, error = function(e) {
    warning(paste("Failed to fetch:", geo_id))
    list(GEO_ID = geo_id, title = NA, overall_design = NA, summary = NA)
  })
})

# Step 4: Convert to data frame
geo_info_df <- bind_rows(geo_info)

# Step 5: Join with your summary metadata
final_metadata <- left_join(metadata, geo_info_df, by = c("unique_sample_series_id" = "GEO_ID"))

# Step 6: Save to CSV using here()
output_file <- here("final_metadata.csv")
write.csv(final_metadata, output_file, row.names = FALSE)

message("Metadata enrichment complete. Saved to: ", output_file)
