#!/usr/bin/shell

size=$1
wkdir=$2

if [ -z $size ];then
	echo "sh run_mapping.sh [size] [wkdir]"
elif [ -z $wkdir ];then
	echo "sh run_mapping.sh [size] [wkdir]"
else
	mkdir -p $wkdir/06.samtools_htseq/$size 
	python $wkdir/script/pipeline_v2.py -b $wkdir/data/Alignment/ -g $wkdir/05.extracted/$size/extracted_$size".gff" -r $wkdir/05.extracted/$size/extracted_$size".bed" -o $wkdir/06.samtools_htseq/$size
fi
