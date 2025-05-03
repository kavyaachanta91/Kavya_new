
library(dplyr)

# Specify the folder containing the CSV files
folder_path <- "/Users/kachanta/Desktop/prostate_Natalie/gse_raw/"

# Get a list of all CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "*.csv", full.names = TRUE)

# Define the required columns
selected_columns <- c("sample_molecule_ch1", "sample_molecule_ch2", "sample_source_name_ch1", "sample_status", "sample_library_selection", 
                      "sample_library_source", "sample_extract_protocol_ch1", "sample_extract_protocol_ch2", "sample_label_protocol_ch1", "sample_source_name_ch2",
                      "sample_library_strategy", "sample_characteristics_ch2", "sample_label_protocol_ch2", "sample_label_protocol",
                      "sample_series_id", "sample_data_processing", "sample_description", "sample_characteristics_ch1", "sample_organism_ch1",
                      "tissue", "sample_type", "sample_title", "sample_name", "sample_hyb_protocol", "sample_label_ch2", "disease_state", "sample_label_ch2","ethnicity","disease_state", "time_point","tmprss2",
                      "treatment", "sample_source_name_ch2", "cancer_status", "tissuer_type","tumor_type", "age", "gleason_score","pathologic_tumor_stage", "gleason_grade","t-stage","margin_status","preop_psa","bcr","bcr_free_time")

# Process each file
for (file in csv_files) {
  # Read the CSV file
  data <- read.csv(file)
  
  # Ensure all required columns are present, adding NA for missing columns
  for (col in selected_columns) {
    if (!col %in% names(data)) {
      data[[col]] <- NA
    }
  }
  
  # Keep only the selected columns
  data <- data %>% dplyr::select(all_of(selected_columns))
  
  # Generate an output file name
  output_file <- paste0("processed_", basename(file))
  
  # Save the modified CSV file
  write.csv(data, file.path("/Users/kachanta/Desktop/prostate_Natalie/output_3/", output_file), row.names = FALSE)
}



# Get a list of all CSV files in the directory
file_list <- list.files(folder_path, pattern = "\\.csv$", full.names = TRUE)

# Initialize an empty list to store the unique values
unique_values_list <- list()

# Loop through each CSV file
for (file in csv_files) {
  # Read the CSV file
  df <- read.csv(file)
  
  # Extract unique values from the 'sample_source_name_ch1' column
  unique_values <- unique(df$sample_source_name_ch1)
  
  # Store the unique values in the list
  unique_values_list[[file]] <- unique_values
}

# Convert the list to a data frame for easier viewing
unique_values_table <- stack(unique_values_list)

# Display the result
print(unique_values_table)

write.csv(unique_values_table, "/Users/kachanta/Desktop/unique_values_table.csv")


