# Combine VCF files for genome analysis :MutVis_TiTv_Genome
#
# Contributors: @Akshatha Prasanna


# Restore the object
vcf_files <- readRDS(file = "./scripts/vcf_files_vc.rds")

vcf_files_names <- list.files (path = "./data/vcf", recursive = TRUE, full.name = TRUE, pattern = "*.vcf")

for (i in 1:length(vcf_files_names)) {
vcf_files[[i]] <- subset(vcf_files[[i]] , select = -c(POS,ID,QUAL,FILTER,INFO,FORMAT ) )
vcf_files[[i]] <- subset(vcf_files[[i]], select = -c(4:length(colnames(vcf_files[[i]]))))
names(vcf_files[[i]])[names(vcf_files[[i]]) == "#CHROM"] <- "sample"
names(vcf_files[[i]])[names(vcf_files[[i]]) == "REF"] <- "reference"
names(vcf_files[[i]])[names(vcf_files[[i]]) == "ALT"] <- "variant"
     }

for (i in 1:length(vcf_files_names)) {
    filename_vec <- strsplit(vcf_files_names[[i]], split = "/")[[1]][[4]]
    filename_vec_2 <- tools::file_path_sans_ext(filename_vec)
    vcf_files[[i]]$sample <- filename_vec_2
}

library(data.table)

vcf_combine <- rbindlist(vcf_files)

# Save an object to a file
saveRDS(vcf_combine, file = "./scripts/vcf_combine_genome.rds")
