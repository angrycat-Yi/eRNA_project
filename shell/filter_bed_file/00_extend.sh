#!/usr/bin/sh

size=$1
wkdir=$2

if [ -z $size ];then
	echo "input the size"
elif [ -z $wkdir ];then
	echo "input the wkdir"
else
	
	awk '{split($1,a,":");print a[1]"\t"$3"\t"$3+1"\t"$4}' $wkdir/data/raw_bed/200k_eRNA_loci_identity.txt |sed 's/chr//g' > $wkdir/data/raw_bed/200k_eRNA_identity.txt
	
	mkdir $wkdir/00.extend
	
	python $wkdir/script/bed_change.py -b $wkdir/data/raw_bed/200k_eRNA_identity.txt -s $size -o $wkdir/00.extend/200k_eRNA_loci_ext.bed

	python $wkdir/script/bed_change.py -b $wkdir/data/raw_bed/Annotation_eRNA_300k__enhancer_all.bed -s $size -o $wkdir/00.extend/Annotation_eRNA_300k__enhancer.bed

	python $wkdir/script/bed_change.py -b $wkdir/data/raw_bed/F03_63000_typical_enhancer.bed -s $size -o $wkdir/00.extend/F03_63000_enhancer_ext.bed

fi
