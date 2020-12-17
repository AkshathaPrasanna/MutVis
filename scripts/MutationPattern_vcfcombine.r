# install.packages("rlist")

# library(data.table)
# library(rlist)
# library(dplyr)
# library(MutationalPatterns)
# library(gridExtra)
# library(grid)
# library(ggplot2)
# library(lattice)

# Creata a list of path of the count matrix files

list_matrix <- list.files (path = "../Candidate_gene_analysis/helmsman/AtpE_helmsman", recursive = TRUE, full.name = TRUE, pattern = "subtype_count_matrix_spectra.txt")

list_matrix

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

df_t <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {

    temp_col_norm <- vector(mode = "list", length = length(mu_counts[[i]]))

    for (j in 1:length(mu_counts[[i]])){


        temp_col_norm[j] <- sqrt(sum(mu_counts[[i]][j]^2))
        }

   df_t[[i]] <- as.data.frame(temp_col_norm, col.names = colnames(mu_counts[[i]]))
}


# Add the first column to the transposed dataframe

library(rlist)

for (i in 1:length(list_matrix)) {
    filename_vec <- strsplit(list_matrix[[i]], split = "/")[[1]]
    filename_vec_2 <- strsplit(filename_vec[[5]], split = "_")[[1]]
    ID <- filename_vec_2[[1]]
    df_t[[i]]<- cbind(ID,df_t[[i]])
}
filename_vec
filename_vec_2
head(df_t[[1]])

# Format dataframe compatible to MutationalPatterns package

library(musigtools)
msm_MutationalPatterns <- vector(mode = "list", length = length(list_matrix))

for (i in 1:length(list_matrix)) {
msm_MutationalPatterns[[i]] <- format_counts(df_t[[i]], "MutationalPatterns")
    }

# Combine columns of msm_MutationalPatterns

library(rlist)
msm_MutationalPatterns_combined <- list.cbind(msm_MutationalPatterns)

library(MutationalPatterns)
pdf(file="plot_96_profile.pdf")
plot_96_profile(msm_MutationalPatterns_combined[,c(1,2)],condensed = TRUE, ymax=0.3)
dev.off()

library("NMF")

msm_MutationalPatterns_combined_nmf <- msm_MutationalPatterns_combined + 0.0001


estimate <- nmf(msm_MutationalPatterns_combined_nmf, rank= 1:10, method="brunet", nrun=10, seed=123456)
pdf(file="Nmf_rank.pdf")
plot(estimate)
dev.off()

nmf_res_2<- extract_signatures(msm_MutationalPatterns_combined_nmf, rank = 2, nrun = 10)


colnames(nmf_res_2$signatures) <- c("Signature A", "Signature B")
rownames(nmf_res_2$contribution) <- c("Signature A", "Signature B")

pdf(file="96_profile_Signature_2.pdf")
plot_96_profile(nmf_res_2$signatures, condensed = TRUE, ymax=0.1)
dev.off()

library(gridExtra)

pc1 <- plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                          mode = "relative")
pc2 <- plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                          mode = "absolute")
pdf(file="signature_2.pdf")
grid.arrange(pc1, pc2)
dev.off()


plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                   mode = "absolute", coord_flip = TRUE)

pch1 <- plot_contribution_heatmap(nmf_res_2$contribution,
sig_order = c("Signature A", "Signature B"))
pch2 <- plot_contribution_heatmap(nmf_res_2$contribution, cluster_samples=FALSE)
pdf(file="contribution_heatmap_2.pdf")
grid.arrange(pch1, pch2, ncol = 2, widths = c(2,1.6))
dev.off()
