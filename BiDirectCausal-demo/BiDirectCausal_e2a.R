# setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\BiDirectCausal-demo")

# # install.packages("devtools")
# devtools::install_github("xue-hr/MRCD")
# devtools::install_github("xue-hr/MRcML")
# devtools::install_github("xue-hr/BiDirectCausal")

library(dplyr)
library(data.table)
# memory.limit(9999999999)

print("Reading data......")
asthma_gss = fread("asthma_GRCh37.gz", header = T)
ever_smoke_gss = fread("ever_smoked_GRCh37.gz", header = T)
print("Done......")

#  apply our bi-directional CDcML methods
library(MRcML)
library(MRCD)
library(BiDirectCausal)

print("Running......")
start_time = Sys.time()
BiDirCDMethod(b_X = ever_smoke_gss$BETA,
           b_Y = asthma_gss$BETA,
           se_X = ever_smoke_gss$SE,
           se_Y = asthma_gss$SE,
           n_X = mean(ever_smoke_gss$N),
           n_Y = mean(asthma_gss$N),
           sig.cutoff = 5e-8, 
           random.seed = 201101)
end_time = Sys.time()
running_time = end_time - start_time
running_time