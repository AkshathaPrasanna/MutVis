

# Contributors: @Akshatha Prasanna

# Combine columns of msm_MutationalPatterns

# Restore the object
msm_MutationalPatterns <- readRDS(file = "./scripts/msm_MutationalPatterns.rds")

library(rlist)
msm_MutationalPatterns_combined <- list.cbind(msm_MutationalPatterns)

# Save an object to a file
saveRDS(msm_MutationalPatterns_combined, file = "./scripts/msm_MutationalPatterns_combined.rds")


# Remove rds file
file.remove("./scripts/msm_MutationalPatterns.rds")
