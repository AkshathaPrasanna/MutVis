# Contributors: @Akshatha Prasanna
# Combine columns of msm_MutationalPatterns


# Restore the object
msm_MutationalPatterns_combined <- readRDS(file = "./scripts/msm_MutationalPatterns_combined.rds")

library(MutationalPatterns)
pdf(file="./plots/plot_96_profile.pdf")
plot_96_profile(msm_MutationalPatterns_combined[,c(1,2,3,4,5)],condensed = TRUE, ymax=0.3)
dev.off()

library("NMF")

msm_MutationalPatterns_combined_nmf <- msm_MutationalPatterns_combined + 0.0001


estimate <- nmf(msm_MutationalPatterns_combined_nmf, rank= 1:10, method="brunet", nrun=10, seed=123456)

pdf(file="./plots/Nmf_rank_cophenetic.pdf")
# plot(estimate)
plot(estimate, 'cophenetic')
dev.off()

pdf(file="./plots/Nmf_rank_rss.pdf")
# plot(estimate)
plot(estimate, 'rss')
dev.off()

cat("Enter the required number of signatures based on NMF rank survey: ")
n <- readLines(file("stdin"),1)
print(n)


nmf_res_2<- extract_signatures(msm_MutationalPatterns_combined_nmf, rank = 2, nrun = 10)


colnames(nmf_res_2$signatures) <- c("Signature A", "Signature B")
rownames(nmf_res_2$contribution) <- c("Signature A", "Signature B")

pdf(file="./plots/Mutational_signatures.pdf")
plot_96_profile(nmf_res_2$signatures, condensed = TRUE, ymax=0.1)
dev.off()

library(gridExtra)

pc1 <- plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                          mode = "relative")
pc2 <- plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                          mode = "absolute")
pdf(file="./plots/signatures_relative_contribution.pdf")
grid.arrange(pc1, pc2)
dev.off()


plot_contribution(nmf_res_2$contribution, nmf_res_2$signature,
                   mode = "absolute", coord_flip = TRUE)

pch1 <- plot_contribution_heatmap(nmf_res_2$contribution,
sig_order = c("Signature A", "Signature B"))
pch2 <- plot_contribution_heatmap(nmf_res_2$contribution, cluster_samples=FALSE)
pdf(file="./plots/cluster_heatmap.pdf")
grid.arrange(pch1, pch2, ncol = 2, widths = c(2,1.6))
dev.off()


# Remove rds file
file.remove("./scripts/msm_MutationalPatterns_combined.rds")
