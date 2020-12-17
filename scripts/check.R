# combine columns of norm-matrix and create a transpose
#
# Contributors: @Akshatha Prasanna

# Restore the object
df_t <- readRDS(file = "./scripts/df_norm.rds")

list_matrix <- list.files (path = "./output_helmsman", recursive = TRUE, full.name = TRUE, pattern = "subtype_count_matrix_spectra.txt")


# Add the first column to the transposed dataframe


library(rlist)

for (i in 1:length(list_matrix)) {
    filename_vec <- strsplit(list_matrix[[i]], split = "/")[[1]]
    print(filename_vec)
    filename_vec_2 <- strsplit(filename_vec[[3]], split = "_")[[1]]
    ID <- filename_vec_2[[1]]
    df_t[[i]]<- cbind(ID,df_t[[i]])
}

# Save an object to a file
saveRDS(df_t, file = "./scripts/df_t.rds")

file.remove("./scripts/df_norm.rds")
