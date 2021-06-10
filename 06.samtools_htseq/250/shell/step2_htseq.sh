#!/bin/sh
#$ -V                   # this makes it verbose
#$ -j y                 # and put all output (inc errors) into it
#$ -pe smp 1            # Request 4 CPU cores
#$ -l h_rt=120:0:0      # Request 12 hour runtime (upto 240 hours)
#$ -l h_vmem=16G                # Request 4GB RAM / core
#$ -t 1-55 
#$ -N Hisat2-HiSat2_Align


BAMs=(ls $(find /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq/250/01.samtools -name *bam))

BAM=${BAMs[${SGE_TASK_ID}]}
temp=${BAM##*/}
sample=$(basename ${temp%%.*})
source /data/home/hfx472/envs/htseq-count/bin/activate
	
htseq-count -f bam -s reverse $BAM /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/250/extracted_250.gff > /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq/250/02.htseq/$sample"_Counts.txt" 
deactivate

