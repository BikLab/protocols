#!/bin/bash

#SBATCH --job-name="import-data"
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=30-00:00:00
#SBATCH --mail-user=taruna.aggarwal@ucr.edu
#SBATCH --mail-type=END,FAIL
#SBATCH -e import-data-%j.err
#SBATCH -o import-data-%j.out

module unload python
module load qiime2/2017.12

# set the directory containing the input raw reads.
DATA_DIR=/bigdata/biklab/shared/memb/18S/data-clean/raw_fastq

# set the output directory where the Qiime2 artifact will be written
OUTPUT=/bigdata/biklab/shared/memb/18S/qiime2-analysis/data-clean

# import fastq file as Qiime2 artifact
# The raw files must be named in the following manner sampleID_BARCODE_LANE_R*_001.fastq when importing with 
# --source-format CasavaOneEightSingleLanePerSampleDirFmt 
# There are others formats that can be used to import raw fastqs into Qiime2. See https://docs.qiime2.org/2018.4/tutorials/importing/ for more details.
qiime tools import \
--type 'SampleData[PairedEndSequencesWithQuality]' \
--input-path $DATA_DIR/ \
--source-format CasavaOneEightSingleLanePerSampleDirFmt \
--output-path $OUTPUT/memb1-demux-PE-reads.qza