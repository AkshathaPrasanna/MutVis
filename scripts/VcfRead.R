# Reads VCf files from the folder data/vcf
#
# Contributors: @Akshatha Prasanna


vcf_files_vc_names <- list.files (path = "./data/vcf", recursive = TRUE, full.name = TRUE, pattern = "*.vcf")
vcf_files_vc <- vector(mode = "list", length = length(vcf_files_vc_names))
length(vcf_files_vc)

library(data.table)


for (i in 1:length(vcf_files_vc_names)) {
vcf_files_vc[[i]] <- fread(vcf_files_vc_names[[i]], skip = "CHROM")
    }

# Save an object to a file
saveRDS(vcf_files_vc, file = "./scripts/vcf_files_vc.rds")
