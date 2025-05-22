library(dplyr)
library(here)
here()

# Input and output folders relative to project root
input_path <- here("output_2")
output_path <- here("output_3")

# Create output folder if it doesn't exist
if (!dir.exists(output_path)) dir.create(output_path)

# List CSV files
csv_files <- list.files(path = input_path, pattern = "\\.csv$", full.names = TRUE)

# Define columns of interest
selected_columns <- c(
  "sample_molecule_ch1", "sample_molecule_ch2", "sample_source_name_ch1", "sample_status", 
  "sample_library_selection", "sample_library_source", "sample_extract_protocol_ch1", 
  "sample_extract_protocol_ch2", "sample_label_protocol_ch1", "sample_source_name_ch2",
  "sample_library_strategy", "sample_characteristics_ch2", "sample_label_protocol_ch2", 
  "sample_label_protocol", "sample_series_id", "sample_data_processing", "sample_description", 
  "sample_characteristics_ch1", "sample_organism_ch1", "tissue", "sample_type", "sample_title", 
  "sample_name", "sample_hyb_protocol", "sample_label_ch2", "disease_state", "ethnicity", 
  "time_point", "tmprss2", "treatment", "cancer_status", "tissuer_type", "tumor_type", "age", 
  "gleason_score", "pathologic_tumor_stage", "gleason_grade", "t-stage", "margin_status", 
  "preop_psa", "bcr", "bcr_free_time"
)

# Process each CSV file
for (file in csv_files) {
  message("Processing: ", file)
  data <- read.csv(file)
  
  # Add missing columns with NA
  for (col in selected_columns) {
    if (!col %in% names(data)) {
      data[[col]] <- NA
    }
  }
  
  # Select only the required columns
  data <- data %>% select(all_of(selected_columns))
  
  # Write to output directory
  output_file <- paste0("processed_", basename(file))
  write.csv(data, file.path(output_path, output_file), row.names = FALSE)
}

# Collect unique values from a key column across files
unique_values_list <- list()
for (file in csv_files) {
  df <- read.csv(file)
  unique_values_list[[basename(file)]] <- unique(df$sample_source_name_ch1)
}

# Stack and write output
unique_values_table <- stack(unique_values_list)
write.csv(unique_values_table, here("unique_values_table.csv"), row.names = FALSE)
