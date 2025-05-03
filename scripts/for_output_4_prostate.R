# Load necessary library
library(dplyr)

# Define words to filter out
exclude_words <- c("Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with DMSO", "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with Dex", "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with Dox+Dex","Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with RU486+Dex", "Xenograft tissue", "Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with DMSO", "Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with DMSO","Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with DMSO","Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with DMSO","Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with Dex", "Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with Dex","Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with Dex","Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with Dex","Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with RU486+Dex","Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with RU486+Dex","Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with RU486+Dex","Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with RU486+Dex", "peripheral white blood cells", "baseline","peripheral white blood cells", "matched control","peripheral white blood cells", "D1","peripheral white blood cells", "D7","peripheral white blood cells", "D14","peripheral white blood cells", "D21","peripheral white blood cells", "D42","peripheral white blood cells", "D72", " AVG_Signal.1557311004_R004_C007", "xenograft tumor", "patient-derived fibroblasts","DU145", "prostate cancer cells", "Usp9XY", "shRNA", "rep1", "transfection", "control", "unperturbed", "rep2", "Usp9X", "rep3", "scrambled",
                   "sample: 1", "sample: 2", "sample: 3", "sample: 4", "sample: 5", "sample: 6", "sample: 7", "sample: 8", "sample: 9", "sample: 10", "sample: 11", "sample: 12", "sample: 13", "sample: 14", "sample: 15", "sample: 16", "sample: 17", "sample: 18", "sample: 19", "sample: 20", "sample: 21", "sample: 22", "sample: 23", "sample: 24", "sample: 25", "sample: 26", "sample: 27", "sample: 28", "sample: 29", "sample: 30", "sample: 31", "sample: 32", "sample: 33", "sample: 34", "sample: 35", "sample: 36", "sample: 37", "sample: 38", "sample: 39", "sample: 40", "sample: 41", "sample: 42", "sample: 43", "sample: 44", "sample: 45", "sample: 46", "sample: 47", "sample: 48", "sample: 49", "sample: 50", "sample: 51", "sample: 52", "sample: 53", "sample: 54", "sample: 55", "sample: 56", "sample: 57", "sample: 58", "sample: 59", "sample: 60", "sample: 61", "sample: 62", "sample: 63", "sample: 64", "sample: 65", "sample: 66", "sample: 67", "sample: 68", "sample: 69", "sample: 70",
                   "LuCaP 35CR_EOS: control", "LuCaP 35CR_EOS: abi", "LuCaP 35CR_Day 7: control", "LuCaP 35CR_Day 7: abi",
                   "LuCaP 77_EOS: control", "LuCaP 77_EOS: control CX", "LuCaP 77_EOS: abi",
                   "LuCaP 96CR_EOS: control", "LuCaP 96CR_EOS: abi", "LuCaP 96CR_Day 7: control", "LuCaP 96CR_Day 7: abi",
                   "LuCaP 136_EOS: control", "LuCaP 136_EOS: control CX", "LuCaP 136_EOS: abi",
                   "LuCaP 136_Day 7: control", "LuCaP 136_Day 7: abi", "Congenital Nevi","Cutaneous primary melanoma")
                   
                   
 
# Define directory containing CSV files
input_dir <- "/Users/kachanta/Desktop/prostate_Natalie/output_3"


output_dir <- "/Users/kachanta/Desktop/prostate_Natalie/output_4"

# Get list of CSV files in the directory
csv_files <- list.files(input_dir, pattern = "*.csv", full.names = TRUE)

# Function to filter data
filter_data <- function(file) {
  # Read CSV file
  df <- read.csv(file, stringsAsFactors = FALSE)
  
  # Keep only rows where 'sample_molecule_ch1' contains "total RNA" or "poly RNA"
  df_filtered <- df %>%
    filter(grepl("total RNA|poly RNA", sample_molecule_ch1, ignore.case = TRUE)) %>%
    filter(!grepl(paste(exclude_words, collapse = "|"), sample_source_name_ch1, ignore.case = TRUE))
  
  # Save filtered data if not empty
  if (nrow(df_filtered) > 0) {
    output_file <- file.path(output_dir, basename(file))
    write.csv(df_filtered, output_file, row.names = FALSE)
  }
}

# Apply the function to all CSV files
lapply(csv_files, filter_data)

print("Filtering completed and results saved.")
