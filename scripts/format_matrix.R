# format matrix: musigtools
#
# Contributors: @Akshatha Prasanna


# Restore the object
df_t <- readRDS(file = "./scripts/df_t.rds")
list_matrix <- list.files(path="./output_helmsman", recursive=T, pattern="subtype_count_matrix_spectra.txt",full.names=T)

# Format dataframe compatible to MutationalPatterns package

library(devtools)
devtools::install_github("carjed/musigtools")
library(musigtools)
msm_MutationalPatterns <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {
msm_MutationalPatterns[[i]] <- format_counts(df_t[[i]], "MutationalPatterns")
    }

# Save an object to a file
saveRDS(msm_MutationalPatterns, file = "./scripts/msm_MutationalPatterns.rds")

# Remove rds file
file.remove("./scripts/df_t.rds")
