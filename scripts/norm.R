# Calculate norm
#
# Contributors: @Akshatha Prasanna
# Creata a list of path of the count matrix files

library(data.table)

list_matrix <- list.files (path = "./output_helmsman", recursive = TRUE, full.name = TRUE, pattern = "subtype_count_matrix_spectra.txt")


# reading vcf files

mu_counts <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {
mu_counts [[i]] <- read.table(list_matrix[[i]], header=T, stringsAsFactors=F)
    }

# Drop ID column to retain only numeric

subset_df <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {
mu_counts [[i]] <- subset(mu_counts[[i]], select=-c(ID))
    }


# Finding norm of each column

df_norm <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {

    temp_col_norm <- vector(mode = "list", length = length(mu_counts[[i]]))

    for (j in 1:length(mu_counts[[i]])){


        temp_col_norm[j] <- sqrt(sum(mu_counts[[i]][j]^2))
        }

   df_norm[[i]] <- as.data.frame(temp_col_norm, col.names = colnames(mu_counts[[i]]))
}


# Save an object to a file
saveRDS(df_norm, file = "./scripts/df_norm.rds")
