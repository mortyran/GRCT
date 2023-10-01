# Author: Mingyu Ran

setwd("C:\\Users\\acer\\Desktop\\westlake-university\\life-science-college\\rotation\\the-first-rotation\\tutorial\\LCV-demo")

#Start with data munged using the ldsc package
#Load trait 1 data and calculate Zs
d1 = na.omit(read.table(gzfile("ever_smoke_gss_ldsc_input.sumstats.gz"),header=TRUE,sep="\t",stringsAsFactors = FALSE))

#Load trait 2 data and calculate Zs
d2 = na.omit(read.table(gzfile("asthma_gss_ldsc_input.sumstats.gz"),header=TRUE,sep="\t",stringsAsFactors = FALSE))

#Load trait 3 data and calculate Zs
d3 = na.omit(read.table(gzfile("lung_cancer_gss_ldsc_input.sumstats.gz"),header=TRUE,sep="\t",stringsAsFactors = FALSE))


#Load LD scores
ld_scores=read.table("UKBB.EUR.rsid.l2.ldscore.gz",header=TRUE,sep='\t',stringsAsFactors=FALSE)

#################### e2a ######################
#Merge
m = merge(ld_scores,d1,by="SNP")
data = merge(m,d2,by="SNP")

#Sort by position 
data = data[order(data[,"CHR"],data[,"BP"]),]

#Flip sign of one z-score if opposite alleles-shouldn't occur with UKB data
#If not using munged data, will have to check that alleles match-not just whether they're opposite A1/A2
mismatch = which(data$A1.x!=data$A1.y,arr.ind=TRUE)
data[mismatch,]$Z.y = data[mismatch,]$Z.y*-1
data[mismatch,]$A1.y = data[mismatch,]$A1.x
data[mismatch,]$A2.y = data[mismatch,]$A2.x


#Run LCV-need to setwd to directory containing LCV package
source("RunLCV.R")

start_time = Sys.time()
e2a_LCV = RunLCV(data$L2,data$Z.x,data$Z.y)
e2a_LCV
sprintf("Estimated posterior gcp=%.2f(%.2f), log10(p)=%.1f; estimated rho=%.2f(%.2f)",e2a_LCV$gcp.pm, e2a_LCV$gcp.pse, log(e2a_LCV$pval.gcpzero.2tailed)/log(10), e2a_LCV$rho.est, e2a_LCV$rho.err)
end_time = Sys.time()
running_time = end_time - start_time

#################### e2l ######################
#Merge
m = merge(ld_scores,d1,by="SNP")
data = merge(m,d3,by="SNP")

#Sort by position 
data = data[order(data[,"CHR"],data[,"BP"]),]

#Flip sign of one z-score if opposite alleles-shouldn't occur with UKB data
#If not using munged data, will have to check that alleles match-not just whether they're opposite A1/A2
mismatch = which(data$A1.x!=data$A1.y,arr.ind=TRUE)
data[mismatch,]$Z.y = data[mismatch,]$Z.y*-1
data[mismatch,]$A1.y = data[mismatch,]$A1.x
data[mismatch,]$A2.y = data[mismatch,]$A2.x


#Run LCV-need to setwd to directory containing LCV package
source("RunLCV.R")

start_time = Sys.time()
e2l_LCV = RunLCV(data$L2,data$Z.x,data$Z.y)
e2l_LCV
sprintf("Estimated posterior gcp=%.2f(%.2f), log10(p)=%.1f; estimated rho=%.2f(%.2f)",e2l_LCV$gcp.pm, e2l_LCV$gcp.pse, log(e2l_LCV$pval.gcpzero.2tailed)/log(10), e2l_LCV$rho.est, e2l_LCV$rho.err)
end_time = Sys.time()
running_time = end_time - start_time

#################### a2l ######################
#Merge
m = merge(ld_scores,d2,by="SNP")
data = merge(m,d3,by="SNP")

#Sort by position 
data = data[order(data[,"CHR"],data[,"BP"]),]

#Flip sign of one z-score if opposite alleles-shouldn't occur with UKB data
#If not using munged data, will have to check that alleles match-not just whether they're opposite A1/A2
mismatch = which(data$A1.x!=data$A1.y,arr.ind=TRUE)
data[mismatch,]$Z.y = data[mismatch,]$Z.y*-1
data[mismatch,]$A1.y = data[mismatch,]$A1.x
data[mismatch,]$A2.y = data[mismatch,]$A2.x


#Run LCV-need to setwd to directory containing LCV package
source("RunLCV.R")

start_time = Sys.time()
a2l_LCV = RunLCV(data$L2,data$Z.x,data$Z.y)
a2l_LCV
sprintf("Estimated posterior gcp=%.2f(%.2f), log10(p)=%.1f; estimated rho=%.2f(%.2f)",a2l_LCV$gcp.pm, a2l_LCV$gcp.pse, log(a2l_LCV$pval.gcpzero.2tailed)/log(10), a2l_LCV$rho.est, a2l_LCV$rho.err)
end_time = Sys.time()
running_time = end_time - start_time


save.image("LCV_result.RData")
