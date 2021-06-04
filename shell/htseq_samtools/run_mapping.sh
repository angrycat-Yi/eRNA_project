#!/usr/bin/shell

size=$1
python ../../script/pipeline.py -b ../../data/Alignment/ -g /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/$size/extracted_$size".gff" -r /data/BCI-Haemato/Yi/analysis/eRNA_project/05.extracted/$size/extracted_$size".bed" -o /data/BCI-Haemato/Yi/analysis/eRNA_project/06.samtools_htseq
