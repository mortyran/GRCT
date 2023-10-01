#!/bin/bash

#slurm options
#SBATCH -p intel-fat           #选择多个分区用逗号隔开
#SBATCH -q hmem                      #Qos只能选一个，否则会报错
#SBATCH -J shared_variants_detecting                   #作业名称
#SBATCH -c 20                            #申请8个CPU核心
#SBATCH --mem=450G
#SBATCH -o %j.log                       #%j表示实际运行时的作业号

## user's own commands below 
module load singularity/3.7.1                 #导入软件环境
singularity exec --bind /storage/yangjianLab/ranmingyu/GRCT/coloc-gg-analysis/coloc-by-gene-region-e2l grct.sif Rscript COLOC_gene_region_cloud.R
