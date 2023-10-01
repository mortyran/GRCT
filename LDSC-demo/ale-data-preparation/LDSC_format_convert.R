setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\LDSC-demo\\ale-data-preparation")

library(dplyr)
library(data.table)
memory.limit(9999999999)

hm3_snps = fread("./w_hm3.snplist", header = T)

asthma_gss = fread("asthma_GRCh37.gz", header = T) %>% filter(SNP %in% hm3_snps$SNP)
lung_cancer_gss = fread("lung_cancer_GRCh37.gz", header = T) %>% filter(SNP %in% hm3_snps$SNP)
ever_smoke_gss = fread("ever_smoked_GRCh37.gz", header = T) %>% filter(SNP %in% hm3_snps$SNP)

ylab_gss_to_ldsc_input = function(ylabGSS) {
  return(ylabGSS[,c(2,4,5,6,13,11)])
}


asthma_gss_ldsc = ylab_gss_to_ldsc_input(ylabGSS = asthma_gss)
lung_cancer_gss_ldsc = ylab_gss_to_ldsc_input(ylabGSS = lung_cancer_gss)
ever_smoke_gss_ldsc = ylab_gss_to_ldsc_input(ylabGSS = ever_smoke_gss)

fwrite(asthma_gss_ldsc, file = "asthma_gss_ldsc", row.names = F, col.names = T, sep = "\t", quote = F)
fwrite(lung_cancer_gss_ldsc, file = "lung_cancer_gss_ldsc", row.names = F, col.names = T, sep = "\t", quote = F)
fwrite(ever_smoke_gss_ldsc, file = "ever_smoke_gss_ldsc", row.names = F, col.names = T, sep = "\t", quote = F)
