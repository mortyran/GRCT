setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\COLOC-demo")

library(dplyr)
library(data.table)

################################ gene region ######################################
# gene_region_50K a2l
coloc_gene_region = readRDS("./coloc-by-gene-region-a2l/coloc_h4_index_gene_region_10K.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_1M a2l
coloc_gene_region = readRDS("./coloc-by-gene-region-a2l/coloc_h4_index_gene_region_10K.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_1M a2l
coloc_gene_region = readRDS("./coloc-by-gene-region-a2l/coloc_h4_index_gene_region_10K.rds")
any(!is.na(coloc_gene_region$index))



# gene_region_50K e2l
coloc_gene_region = readRDS("./coloc-by-gene-region-e2l/coloc_h4_index_gene_region_50K.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_1M e2l
coloc_gene_region = readRDS("./coloc-by-gene-region-e2l/coloc_h4_index_gene_region_1M.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_10K e2l
coloc_gene_region = readRDS("./coloc-by-gene-region-e2l/coloc_h4_index_gene_region_10K.rds")
any(!is.na(coloc_gene_region$index))


# gene_region_50K e2a
coloc_gene_region = readRDS("./coloc-by-gene-region-e2a/coloc_h4_index_gene_region_50K.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_1M e2a
coloc_gene_region = readRDS("./coloc-by-gene-region-e2a/coloc_h4_index_gene_region_1M.rds")
any(!is.na(coloc_gene_region$index))

# gene_region_10K e2a
coloc_gene_region = readRDS("./coloc-by-gene-region-e2a/coloc_h4_index_gene_region_10K.rds")
any(!is.na(coloc_gene_region$index))





### checking
genome_region = fread("./source-data/gene_regions_GRCh37", header = F)
genome_region = genome_region %>% filter(V1 %in% c(1:22)) %>% filter_all(all_vars(. != ""))

asthma_gss = fread("./source-data/asthma_GRCh37.gz", header = T)
lung_cancer_gss = fread("./source-data/lung_cancer_GRCh37.gz", header = T)
ever_smoke_gss = fread("./source-data/ever_smoked_GRCh37.gz", header = T)

ylab_gss_to_coloc_input = function(ylabGSS, chrID="5", start_pos=148753830, end_pos=148783765, regionExpanded=50000){
  ylabGSS = ylabGSS %>% filter(as.character(CHR) == chrID & as.numeric(POS) >= (start_pos - regionExpanded) & as.numeric(POS) <= (end_pos + regionExpanded))
  beta = as.numeric(ylabGSS$BETA)
  varbeta = as.numeric(ylabGSS$SE ^ 2)
  snp = as.character(ylabGSS$SNP)
  position = as.numeric(ylabGSS$POS)
  type = "cc"
  return(list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type))
}

x=7160
genome_region[,c(5,6)][x]
chrID = genome_region$V1[x]
start_pos = genome_region$V2[x]
end_pos = genome_region$V3[x]
ever_smoke_coloc_input = ylab_gss_to_coloc_input(ylabGSS = ever_smoke_gss, chrID = chrID, start_pos = start_pos, end_pos = end_pos)
lung_cancer_coloc_input = ylab_gss_to_coloc_input(ylabGSS = lung_cancer_gss, chrID = chrID, start_pos = start_pos, end_pos = end_pos)
coloc_result <- coloc.abf(dataset1=ever_smoke_coloc_input,
                            dataset2=lung_cancer_coloc_input)
subset(coloc_result$results,SNP.PP.H4>0.2)
