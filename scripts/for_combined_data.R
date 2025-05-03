# Load necessary library
library(dplyr)

# Define directory containing CSV files
input_dir <- "/Users/kachanta/Desktop/prostate_Natalie/output_5"


# Get list of CSV files
csv_files <- list.files(input_dir, pattern = "*.csv", full.names = TRUE)

# Read and combine all CSV files
combined_data <- do.call(rbind, lapply(csv_files, read.csv, stringsAsFactors = FALSE))

# Save the combined data to a new CSV file
write.csv(combined_data, "combined_data.csv", row.names = FALSE)


