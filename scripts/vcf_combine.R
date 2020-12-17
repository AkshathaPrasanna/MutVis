# not included


# Restore the object
vcf_pos<-readRDS(file = "vcf_pos.rds")

library(data.table)

vcf_combine <- rbindlist(vcf_pos)

# Save an object to a file
saveRDS(vcf_combine, file = "vcf_combine_gene.rds")

# Remove rds file
file.remove("vcf_pos.rds")
