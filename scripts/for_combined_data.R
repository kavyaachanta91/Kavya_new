library(dplyr)
library(here)

# Define input directory using here()
input_dir <- here("output_5")

# Get list of CSV files
csv_files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Read and combine all CSV files
combined_data <- do.call(rbind, lapply(csv_files, read.csv, stringsAsFactors = FALSE))

# Define output file path using here()
output_file <- here("combined_data.csv")

# Save combined data
write.csv(combined_data, output_file, row.names = FALSE)

message("CSV files combined and saved to: ", output_file)
