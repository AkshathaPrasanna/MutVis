
# Restore the object
vcf_pos<-readRDS(file = "vcf_pos.rds")

library(GenVisR)
vcf_combine <- rbindlist(vcf_pos)

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
