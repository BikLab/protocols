#!/bin/bash

#SBATCH --job-name="fastqc"
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30-00:00:00
#SBATCH --mail-user=taruna@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e fastqc-%j.err
#SBATCH -o fastqc-%j.out

module load fastqc

# Set input and output directories. 
# This script assumes that there is an input directory for each sample containing R1 and R2 fastq.gz files.
# The output directory will contain directories for each sample.
IN="/bigdata/biklab/shared/bitmab2-whole-genomes/data-raw/illumina-Flex-kit/"
OUT="/bigdata/biklab/shared/bitmab2-whole-genomes/data-clean/fastqc-v0.11.7/"



for dir in $IN/*;
	do
		fbname=$(basename $dir);
		fastqc \
		-o $OUT \
		$IN$fbname"/"*fastq.gz -f fastq
	done