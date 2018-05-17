#!/bin/bash

#SBATCH --job-name="combining_fastqs"
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30-00:00:00
#SBATCH --mail-user=taruna@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e combining_fastqs-%j.err
#SBATCH -o combining_fastqs-%j.out

IN="/bigdata/biklab/shared/bitmab2-whole-genomes/data-raw/Set1"

for dir in $(ls $IN)
do
    if [ $(ls $dir |grep "R1" | wc -l) -gt 1 ]; then
       fbname=$(basename $dir)
       zcat $dir/*R1* > $dir/$fbname.r1.fastq
       zcat $dir/*R2* > $dir/$fbname.r2.fastq
    fi
done
