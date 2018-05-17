#!/bin/bash

#SBATCH --job-name="dada2"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30-00:00:00
#SBATCH --mail-user=taruna.aggarwal@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e dada2-%j.err
#SBATCH -o dada2-%j.out

module unload python
module load qiime2/2017.12

# Set the directory containing the input Qiime 2 artifact
INPUT=/bigdata/biklab/shared/memb/18S/qiime2-analysis/data-clean

# Set the output directory where the Qiime2 ASV table and rep seqs will be written
OUTPUT=/bigdata/biklab/shared/memb/18S/qiime2-analysis/analysis-results/dada2

# Run dada2 on the imported qza
# The user defines the trimming parameters after visualizing the imported raw reads 
qiime dada2 denoise-paired \
--i-demultiplexed-seqs $INPUT/memb1-demux-PE-reads.qza \
--p-trim-left-f 10 \
--p-trim-left-r 10 \
--p-trunc-len-f 250 \
--p-trunc-len-r 250 \
--p-n-threads 12 \
--o-representative-sequences $OUTPUT/dada2-rep-seqs.qza \
--o-table $OUTPUT/dada2-table.qza