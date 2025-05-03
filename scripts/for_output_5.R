# Load necessary libraries
library(dplyr)
library(tidyr)

# Define directory containing CSV files
input_dir <- "/Users/kachanta/Desktop/prostate_Natalie/output_3"
output_dir <- "/Users/kachanta/Desktop/prostate_Natalie/output_4"

# Get list of CSV files in the directory
csv_files <- list.files(input_dir, pattern = "*.csv", full.names = TRUE)

# Function to process data
process_data <- function(file) {
  # Read CSV file
  df <- read.csv(file, stringsAsFactors = FALSE)
  
  # Count rows where 'sample_molecule_ch1' contains "total RNA" or "poly RNA"
  total_samples <- sum(grepl("total RNA|poly RNA", df$sample_molecule_ch1, ignore.case = TRUE))
  
  # Collapse unique values of each column into a single row
  df_unique <- df %>%
    summarise(across(everything(), ~ paste(unique(.), collapse = ","), .names = "unique_{.col}"))
  
  # Add total samples column
  df_unique$total_samples <- total_samples
  
  # Save processed data
  output_file <- file.path(output_dir, basename(file))
  write.csv(df_unique, output_file, row.names = FALSE)
}

# Apply function to all CSV files
lapply(csv_files, process_data)

print("Processing completed and results saved.")
