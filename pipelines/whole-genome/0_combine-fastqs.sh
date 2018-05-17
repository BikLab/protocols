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

for dir in $IN/*;
	do
		cd $dir;
			for f in $(ls);
			do 
				fbname=$(basename $f | cut -d "R" -f 1 -);
				zcat *R1* > ${fbname}R1.fastq;
				zcat *R2* > ${fbname}R2.fastq;
			done
	done		
