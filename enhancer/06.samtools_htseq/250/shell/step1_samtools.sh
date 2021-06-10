#!/bin/sh
#$ -V                   # this makes it verbose
#$ -j y                 # and put all output (inc errors) into it
#$ -pe smp 1            # Request 4 CPU cores
#$ -l h_rt=120:0:0      # Request 12 hour runtime (upto 240 hours)
#$ -l h_vmem=16G                # Request 4GB RAM / core
#$ -t 1-55 
#$ -N Hisat2-HiSat2_Align
 
		
BAMs=(ls $(find /data/BCI-Haemato/Yi/data/Alignment/ -name *bam))

BAM=${BAMs[${SGE_TASK_ID}]}
sample=$(basename ${BAM%%.*})

module load samtools

samtools view -bh -L /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/250/extracted_250.bed $BAM > /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq/250/01.samtools/$sample".bam"

module unload samtools

