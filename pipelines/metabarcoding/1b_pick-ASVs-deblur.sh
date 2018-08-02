#!/bin/bash

#SBATCH --job-name="deblur"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30-00:00:00
#SBATCH --mail-user=taruna.aggarwal@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e deblur-%j.err
#SBATCH -o deblur-%j.out

export LC_ALL=en_US.utf-8
export LANG=en_US.utf-8
#module load python
source activate qiime2-2018.6


# Set the directory containing the input Qiime 2 artifact
INPUT=/bigdata/biklab/shared/memb/16S/qiime2-analysis/data-clean

# Set the output directory where the Qiime2 ASV table and rep seqs will be written
OUTPUT=/bigdata/biklab/shared/memb/16S/qiime2-analysis/analysis-results/deblur
STATS=/bigdata/biklab/shared/memb/16S/qiime2-analysis/analysis-results/deblur-stats
# quality filter sequences

qiime quality-filter q-score \
--i-demux $INPUT/memb1-demux-PE-reads.qza \
 --o-filtered-sequences $OUTPUT/memb1-demux-PE-reads-filtered.qza \
 --o-filter-stats $STATS/memb1-demux-PE-reads-filtered-stats.qza

qiime deblur denoise-16S \
--i-demultiplexed-seqs $OUTPUT/memb1-demux-PE-reads-filtered.qza \
--p-sample-stats \
--p-trim-length 250 \
--o-representative-sequences $OUTPUT/deblur-rep-seqs.qza \
--o-table $OUTPUT/deblur-table.qza \
--output-dir /bigdata/biklab/shared/memb/16S/qiime2-analysis/analysis-results/deblur