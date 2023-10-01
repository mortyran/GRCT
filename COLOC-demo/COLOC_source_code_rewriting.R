setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\COLOC-demo")

library(dplyr)
library(data.table)
library(coloc)

memory.limit(9999999999)

asthma_gss = fread("./source-data/asthma_GRCh37.gz", header = T)
lung_cancer_gss = fread("./source-data/lung_cancer_GRCh37.gz", header = T)
# ever_smoke_gss = fread("./source-data/ever_smoked_GRCh37.gz", header = T)
# save.image(file = "./traits_coloc.RData")

# select interesting genome region
# IL17: chr5, 148753830..148783765
genome_region = fread("./source-data/gene_regions_GRCh37", header = F)
genome_region = genome_region %>% filter(V1 %in% c(1:22)) %>% filter_all(all_vars(. != ""))

ylab_gss_to_coloc_input = function(ylabGSS, chrID="5", region=c(148753830, 148783765), regionExpanded=50000){
  ylabGSS = ylabGSS %>% filter(as.character(CHR) == chrID & as.numeric(POS) >= (region[1] - regionExpanded) & as.numeric(POS) <= (region[2] + regionExpanded))
  beta = as.numeric(ylabGSS$BETA)
  varbeta = as.numeric(ylabGSS$SE ^ 2)
  snp = as.character(ylabGSS$SNP)
  position = as.numeric(ylabGSS$POS)
  type = "cc"
  return(list(beta = beta, varbeta = varbeta, snp = snp, position = position, type = type))
}

asthma_coloc_input = ylab_gss_to_coloc_input(ylabGSS = asthma_gss)
check_dataset(asthma_coloc_input)
plot_dataset(asthma_coloc_input)

# ever_smoke_coloc_input = ylab_gss_to_coloc_input(ylabGSS = ever_smoke_gss)
# check_dataset(ever_smoke_coloc_input)
# plot_dataset(ever_smoke_coloc_input)

lung_cancer_coloc_input = ylab_gss_to_coloc_input(ylabGSS = lung_cancer_gss)
check_dataset(lung_cancer_coloc_input)
plot_dataset(lung_cancer_coloc_input)

# processing data
dataset1=asthma_coloc_input
dataset2=lung_cancer_coloc_input
MAF=NULL

df1 <- process.dataset(d=dataset1, suffix="df1")
d=dataset1
nd <- names(d)
suffix = "df1"
df <- approx.bf.estimates(z=d$beta/sqrt(d$varbeta),
                          V=d$varbeta, type=d$type, suffix=suffix, sdY=d$sdY)
df$snp <- as.character(d$snp)
if("position" %in% nd)
  df <- cbind(df,position=d$position)



df2 <- process.dataset(d=dataset2, suffix="df2")