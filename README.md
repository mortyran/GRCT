# GRCT
GRCT mainly includes demo codes for analyzing genetic relationships between complex traits (GRCT) from GWAS summary data as well as some knowledge in genomics filed.  

**Data download:**  
asthma_GRCh37.gz can be download from [here](https://yanglab.westlake.edu.cn/data/fastgwa_data/UKBbin/495_PheCode.v1.0.fastGWA.gz).  
ever_smoked_GRCh37.gz can be download from [here](https://yanglab.westlake.edu.cn/data/fastgwa_data/UKBbin/20160.v1.0.fastGWA.gz).  
lung_cancer_GRCh37.gz can be download from [here](https://yanglab.westlake.edu.cn/data/fastgwa_data/UKBbin/165.1_PheCode.v1.0.fastGWA.gz).  

**Docker image** `grct:v1.0` can be pulled as following command:  
`docker pull ranmingyu/grct:v1.0`

**Included tools:**  
genetic correlation: `[LDSC](https://github.com/bulik/ldsc)`  
causative relationship: `[LCV](https://github.com/lukejoconnor/LCV)`, `[BiDirectCausal](https://github.com/xue-hr/BiDirectCausal)`    
pleiotropy loci: `[COLOC](https://github.com/chr1swallace/coloc)` (demo code for GWAS to GWAS)  
  
**Author:** Mingyu-Ran  
**E-mail:** ranmingyu@westlake.edu.cn  
**Date:** October 2, 2023
