#! /bin/bash
# setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\COLOC-demo\\coloc-by-SNP-region")

library(dplyr)
library(data.table)
# library(coloc)
# memory.limit(9999999999)

print("Reading data......")
asthma_gss = fread("asthma_GRCh37.gz", header = T)
lung_cancer_gss = fread("lung_cancer_GRCh37.gz", header = T)
# ever_smoke_gss = fread("ever_smoked_GRCh37.gz", header = T)
# save.image(file = "./traits_coloc.RData")

# select interesting genome region
# IL17: chr5, 148753830..148783765
genome_region = fread("gene_regions_GRCh37", header = F)
genome_region = genome_region %>% filter(V1 %in% c(1:22)) %>% filter_all(all_vars(. != ""))

ylab_gss_to_coloc_input = function(ylabGSS, chrID="5", start_pos=148753830, end_pos=148783765, regionExpanded=50000){
  ylabGSS = ylabGSS %>% filter(as.character(CHR) == chrID & as.numeric(POS) >= (start_pos - regionExpanded) & as.numeric(POS) <= (end_pos + regionExpanded))
  beta = as.numeric(ylabGSS$BETA)
  varbeta = as.numeric(ylabGSS$SE ^ 2)
  snp = as.character(ylabGSS$SNP)
  position = as.numeric(ylabGSS$POS)
  type = "cc"
  return(list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type))
}

dir.create("./coloc-by-gene-region/coloc-rs-file")
for(i in 1:nrow(asthma_gss)[1:10000]){
  start_pos = asthma_gss[i,]$POS - 50000
  end_pos = asthma_gss[i,]$POS + 50000
  
  gss1 = asthma_gss %>% filter(POS >= start_pos & POS <= end_pos)
  beta = as.numeric(gss1$BETA)
  varbeta = as.numeric(gss1$SE ^ 2)
  snp = as.character(gss1$SNP)
  position = as.numeric(gss1$POS)
  type = "cc"
  D1=list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type)
  
  gss2 = lung_cancer_gss %>% filter(POS >= start_pos & POS <= end_pos)
  beta = as.numeric(gss2$BETA)
  varbeta = as.numeric(gss2$SE ^ 2)
  snp = as.character(gss2$SNP)
  position = as.numeric(gss2$POS)
  type = "cc"
  D2=list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type)
  
  coloc_D = list(D1=D1, D2=D2)
  print(paste0("Now is ", i))
  # output_name = paste0("./coloc-by-gene-region/coloc-rs-file/", asthma_gss$SNP[i], ".rds")
  # saveRDS(coloc_D, file = output_name)
}

# asthma_coloc_input = ylab_gss_to_coloc_input(ylabGSS = asthma_gss)
# # check_dataset(asthma_coloc_input)
# # plot_dataset(asthma_coloc_input)
# 
# # ever_smoke_coloc_input = ylab_gss_to_coloc_input(ylabGSS = ever_smoke_gss)
# # check_dataset(ever_smoke_coloc_input)
# # plot_dataset(ever_smoke_coloc_input)
# 
# lung_cancer_coloc_input = ylab_gss_to_coloc_input(ylabGSS = lung_cancer_gss)
# # check_dataset(lung_cancer_coloc_input)
# # plot_dataset(lung_cancer_coloc_input)
# 
# coloc_result <- coloc.abf(dataset1=coloc_D[[1]],
#                     dataset2=coloc_D[[2]])
# print(coloc_result)
# subset(coloc_result$results,SNP.PP.H4>0.2)