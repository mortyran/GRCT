#! /bin/bash
# setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\COLOC-demo")

library(dplyr)
library(data.table)
library(coloc)

# memory.limit(9999999999)

print("Reading data......")
asthma_gss = fread("asthma_GRCh37.gz", header = T)
lung_cancer_gss = fread("lung_cancer_GRCh37.gz", header = T)
# ever_smoke_gss = fread("./source-data/ever_smoked_GRCh37.gz", header = T)
# save.image(file = "./traits_coloc.RData")

# select interesting genome region
# IL17: chr5, 148753830..148783765
genome_region = fread("gene_regions_GRCh37", header = F)
genome_region = genome_region %>% filter(V1 %in% c(1:22)) %>% filter_all(all_vars(. != ""))

ylab_gss_to_coloc_input = function(ylabGSS, chrID="5", start_pos=148753830, end_pos=148783765, regionExpanded=1000000){
  ylabGSS = ylabGSS %>% filter(as.character(CHR) == chrID & as.numeric(POS) >= (start_pos - regionExpanded) & as.numeric(POS) <= (end_pos + regionExpanded))
  beta = as.numeric(ylabGSS$BETA)
  varbeta = as.numeric(ylabGSS$SE ^ 2)
  snp = as.character(ylabGSS$SNP)
  position = as.numeric(ylabGSS$POS)
  type = "cc"
  return(list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type))
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
# coloc_result <- coloc.abf(dataset1=asthma_coloc_input,
#                     dataset2=lung_cancer_coloc_input)
# print(coloc_result) 
# subset(coloc_result$results,SNP.PP.H4>0.2)

print("Allocating files......")
library(snow)
cl <- makeCluster(20, type = "SOCK")
clusterExport(cl, c("asthma_gss", "lung_cancer_gss", "genome_region", "ylab_gss_to_coloc_input"))
clusterEvalQ(cl, {
  library(data.table)
  library(dplyr)
  library(coloc)
})
print("Calculating......")
coloc_h4_index = parLapply(cl, c(1:nrow(genome_region)), function(x){
  
  chrID = genome_region$V1[x]
  start_pos = genome_region$V2[x]
  end_pos = genome_region$V3[x]
  
  asthma_coloc_input = ylab_gss_to_coloc_input(ylabGSS = asthma_gss, chrID = chrID, start_pos = start_pos, end_pos = end_pos)
  lung_cancer_coloc_input = ylab_gss_to_coloc_input(ylabGSS = lung_cancer_gss, chrID = chrID, start_pos = start_pos, end_pos = end_pos)
  tryCatch({
    coloc_result <- coloc.abf(dataset1=asthma_coloc_input,
                              dataset2=lung_cancer_coloc_input)
    if(as.numeric(coloc_result$summary[6]) > 0.1 & any(coloc_result$results$SNP.PP.H4 > 0.1)){
      return(x)
    }else{
      return(NA)
    }
  },error = function(e) {
    return(NA)
  })
})
stopCluster(cl)
coloc_h4_index_ = data.frame(index = unlist(coloc_h4_index))

print("Outputing results......")
saveRDS(coloc_h4_index_, file = "coloc_h4_index_gene_region_1M.rds")
