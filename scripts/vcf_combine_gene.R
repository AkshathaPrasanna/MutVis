# Combine VCF files for gene analysis :MutVis_vcf_format
#
# Contributors: @Akshatha Prasanna


# Restore the object
vcf_pos<-readRDS(file = "./scripts/vcf_pos.rds")

library(data.table)

vcf_combine <- rbindlist(vcf_pos)

# Save an object to a file
saveRDS(vcf_combine, file = "./scripts/vcf_combine_gene.rds")

# Remove rds file
file.remove("./scripts/vcf_pos.rds")
