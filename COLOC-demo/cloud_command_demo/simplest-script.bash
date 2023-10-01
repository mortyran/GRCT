#!/bin/bash

## slurm options
#SBATCH -p intel-sc3          # intel-sc3 partition
#SBATCH -q normal             # normal qos
#SBATCH -J test1              # job name

hostname
sleep 10s
