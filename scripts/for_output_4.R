# Load necessary libraries
library(dplyr)
library(here)

# Define keywords or phrases to exclude
exclude_words <- c(
  "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with DMSO",
  "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with Dex",
  "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with Dox+Dex",
  "Immortalized primary human prostate cancer associated fibroblasts (PF179TCAF) w/ shGR treated with RU486+Dex",
  "Xenograft tissue",
  "Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with DMSO",
  "Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with DMSO",
  "Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with DMSO",
  "Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with DMSO",
  "Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with Dex",
  "Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with Dex",
  "Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with Dex",
  "Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with Dex",
  "Primary human prostate cancer associated fibroblasts (PAT1; 3148)  treated with RU486+Dex",
  "Primary human prostate cancer associated fibroblasts (PAT2; 1341)  treated with RU486+Dex",
  "Primary human prostate cancer associated fibroblasts (PAT3; 5201)  treated with RU486+Dex",
  "Primary human prostate cancer associated fibroblasts (PAT4; 1869)  treated with RU486+Dex",
  "peripheral white blood cells", "baseline", "matched control", "D1", "D7", "D14", "D21", "D42", "D72",
  "AVG_Signal.1557311004_R004_C007", "xenograft tumor", "patient-derived fibroblasts", "DU145",
  "prostate cancer cells", "Usp9XY", "shRNA", "rep1", "transfection", "control", "unperturbed",
  "rep2", "Usp9X", "rep3", "scrambled",
  paste0("sample: ", 1:70),
  "LuCaP 35CR_EOS: control", "LuCaP 35CR_EOS: abi", "LuCaP 35CR_Day 7: control", "LuCaP 35CR_Day 7: abi",
  "LuCaP 77_EOS: control", "LuCaP 77_EOS: control CX", "LuCaP 77_EOS: abi",
  "LuCaP 96CR_EOS: control", "LuCaP 96CR_EOS: abi", "LuCaP 96CR_Day 7: control", "LuCaP 96CR_Day 7: abi",
  "LuCaP 136_EOS: control", "LuCaP 136_EOS: control CX", "LuCaP 136_EOS: abi",
  "LuCaP 136_Day 7: control", "LuCaP 136_Day 7: abi",
  "Congenital Nevi", "Cutaneous primary melanoma"
)

# Define input and output directories using here()
input_dir <- here("output_3")
output_dir <- here("output_4")

# Create output directory if it doesn't exist
if (!dir.exists(output_dir)) dir.create(output_dir)

# Get list of CSV files
csv_files <- list.files(input_dir, pattern = "\\.csv$", full.names = TRUE)

# Define filtering function
filter_data <- function(file) {
  df <- read.csv(file, stringsAsFactors = FALSE)
  
  # Keep only rows where sample_molecule_ch1 is "total RNA" or "poly RNA" and exclude unwanted descriptions
  df_filtered <- df %>%
    filter(grepl("total RNA|poly RNA", sample_molecule_ch1, ignore.case = TRUE)) %>%
    filter(!grepl(paste(exclude_words, collapse = "|"), sample_source_name_ch1, ignore.case = TRUE))
  
  if (nrow(df_filtered) > 0) {
    write.csv(df_filtered, file = file.path(output_dir, basename(file)), row.names = FALSE)
  }
}

# Apply filtering to each file
lapply(csv_files, filter_data)

message("Filtering completed and results saved.")
