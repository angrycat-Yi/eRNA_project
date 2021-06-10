#!/usr/bin/shell

size=$1
mkdir -p /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq/$size 
python /data/BCI-Haemato/Yi/analysis/eRNA_project/script/pipeline_v2.py -b /data/BCI-Haemato/Yi/data/Alignment/ -g /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/$size/extracted_$size".gff" -r /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/$size/extracted_$size".bed" -o /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq/$size
