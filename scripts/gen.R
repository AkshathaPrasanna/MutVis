# TVTI plots of selected gene
#
# Contributors: @Akshatha Prasanna


# Restore the object
vcf_combine<-readRDS(file = "vcf_combine.rds")


library(GenVisR)


TvTi(vcf_combine, fileType="MGI")


tvtiFreqGrob <- TvTi(vcf_combine, fileType="MGI", out="grob", type="frequency")
tvtiPropGrob <- TvTi(vcf_combine, fileType="MGI", out="grob", type="proportion")

library(gridExtra)
library(grid)
# finalGrob <- arrangeGrob(tvtiFreqGrob, tvtiPropGrob, ncol=2)
# grid.draw(finalGrob)

pdf(file="gene_TiTv.pdf")

grid.draw(tvtiFreqGrob)
dev.off()


pdf(file="gene_tvtiPropGrob.pdf")

grid.draw(tvtiPropGrob)
dev.off()

# Remove rds file
file.remove("vcf_combine.rds")
