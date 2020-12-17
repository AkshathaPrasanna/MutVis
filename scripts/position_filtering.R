# Sub setting VCf file based on gene coordinates
#
# Contributors: @Akshatha Prasanna


# Restore the object
vcf_files_vc <- readRDS(file = "./scripts/vcf_files_vc.rds")
length(vcf_files_vc)

cat("Enter start coordinate of the gene: ")
x <- readLines(file("stdin"),1)
print(x)

cat("Enter end coordinate of the gene: ")
y <- readLines(file("stdin"),1)
print(y)

vcf_pos <- vector(mode = "list", length = length(vcf_files_vc))


library(dplyr)


for (i in 1:length(vcf_files_vc)) {
    vcf_pos[[i]] <- vcf_files_vc[[i]] %>% filter(POS %in% (x:y))
    }


for (i in 1:length(vcf_pos)) {
vcf_pos[[i]] <- subset(vcf_pos[[i]] , select = -c(POS,ID,QUAL,FILTER,INFO,FORMAT ) )
vcf_pos[[i]] <- subset(vcf_pos[[i]], select = -c(4:length(colnames(vcf_pos[[i]]))))
     }


for (i in 1:length(vcf_pos)) {
names(vcf_pos[[i]])[names(vcf_pos[[i]]) == "#CHROM"] <- "sample"
names(vcf_pos[[i]])[names(vcf_pos[[i]]) == "REF"] <- "reference"
names(vcf_pos[[i]])[names(vcf_pos[[i]]) == "ALT"] <- "variant"
     }

length(vcf_pos)

vcf_files_vc_names <- list.files (path = "./data/vcf", recursive = TRUE, full.name = TRUE, pattern = "*.vcf")

for (i in 1:length(vcf_pos)) {
    filename_vec <- strsplit(vcf_files_vc_names[[i]], split = "/")[[1]][[4]]
    filename_vec_2 <- tools::file_path_sans_ext(filename_vec)
    vcf_pos[[i]]$sample <- filename_vec_2
}


# Save an object to a file
saveRDS(vcf_pos, file = "./scripts/vcf_pos.rds")
