#!/bin/bash

#slurm options
#SBATCH -p intel-sc3,amd-ep2            #选择多个分区用逗号隔开
#SBATCH -q normal                       #Qos只能选一个，否则会报错
#SBATCH -J multi-core                   #作业名称
#SBATCH -c 8                            #申请8个CPU核心
#SBATCH -o %j.log                       #%j表示实际运行时的作业号

## user's own commands below 
module load bwa/0.7.17                  #导入软件环境
module load samtools/1.11
ref=/storage/publicdata/ref/bwa/hg38_UCSC/genome.fa

fq_R1=~/data/A16E79X.R1.fq.gz           #这里是错误的，请将数据存储和读写放到/storage目录下	
fq_R2=~/data/A16E79X.R2.fq.gz
bam=~/data/A16E79X.bam

bwa mem  \
  -t 24 \                               #这里是错误的，24个线程将抢占8个CPU,增加节点调度负担，正确应为8
  -M \
  -R '@RG\tID:sample\tSM:sample\tLB:sample\tPL:Illumina' \
  $ref $fq_R1 $fq_R2 | \
  samtools sort -o - | \
  samtools view -u -o $bam

