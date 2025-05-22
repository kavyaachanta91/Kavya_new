# Load necessary libraries
library(dplyr)
library(tidyr)
library(here)

# Define input and output directories using here()
input_dir <- here("output_4")
output_dir <- here("output_5")

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) dir.create(output_dir)

# Get list of CSV files
csv_files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Function to process data
process_data <- function(file) {
  df <- read.csv(file, stringsAsFactors = FALSE)
  
  # Count rows where 'sample_molecule_ch1' contains "total RNA" or "poly RNA"
  total_samples <- sum(grepl("total RNA|poly RNA", df$sample_molecule_ch1, ignore.case = TRUE))
  
  # Collapse unique values of each column into a single row
  df_unique <- df %>%
    summarise(across(everything(), ~ paste(unique(.), collapse = ","), .names = "unique_{.col}"))
  
  # Add total_samples column
  df_unique$total_samples <- total_samples
  
  # Write processed data to output directory
  write.csv(df_unique, file.path(output_dir, basename(file)), row.names = FALSE)
}

# Apply function to all CSV files
lapply(csv_files, process_data)

message("Processing completed and results saved.")
