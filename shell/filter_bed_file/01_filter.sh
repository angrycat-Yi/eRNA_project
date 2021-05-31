#!/usr/bin/sh

module load bedtools

wkdir=$1

if [ -z $wkdir ];then
	
	echo "please set working directory"
else

	if [ ! -d $wkdir ];then
	
		mkdir -p $wkdir

	else
		## step_1 create black list
		mkdir -p $wkdir/01.blacklist/
		cp $wkdir/data/black_list/* $wkdir/01.blacklist/
		sed 's/chr//g' $wkdir/01.blacklist/blacklist_rmsk.txt > $wkdir/01.blacklist/blacklist_rmsk_ch.txt
		cat $wkdir/01.blacklist/blacklist_biomart.txt $wkdir/01.blacklist/blacklist_rmsk_ch.txt  $wkdir/01.blacklist/coding.bed | sort -k1,1 -k2,2n | bedtools merge -i - -c 4 -o collapse -d 6000 > $wkdir/01.blacklist/black_list.bed
		module load bedtools
		
		#bedtools getfasta -fi /data/BCI-Haemato/Yi/ref/hg38.fa -bed $wkdir/01.blacklist/black_list.bed > $wkdir/01.blacklist/black_list.fasta


		## step_2 exclude the black_list
		mkdir -p $wkdir/02.filter  
		bedtools subtract -a $wkdir/00.extend/200k_eRNA_loci_ext.bed -b $wkdir/01.blacklist/black_list.bed > $wkdir/02.filter/200k_eRNA_loci_fl.bed

		bedtools subtract -a $wkdir/00.extend/Annotation_eRNA_300k__enhancer.bed -b $wkdir/01.blacklist/black_list.bed > $wkdir/02.filter/Annotation_eRNA_300k_enhancer_fl.bed

		bedtools subtract -a $wkdir/00.extend/F03_63000_enhancer_ext.bed -b $wkdir/01.blacklist/black_list.bed > $wkdir/02.filter/F03_63000_enhancer_fl.bed


		## step_3 shorten the bed files to 1bp
		mkdir -p $wkdir/03.short
		python $wkdir/script/short.py -f $wkdir/02.filter/200k_eRNA_loci_fl.bed -o $wkdir/03.short/200k_eRNA_loci.bed -g 200k
		python $wkdir/script/short.py -f $wkdir/02.filter/Annotation_eRNA_300k_enhancer_fl.bed -o $wkdir/03.short/Annotation_eRNA_300k_enhancer.bed -g 300k
		python $wkdir/script/short.py -f $wkdir/02.filter/F03_63000_enhancer_fl.bed -o $wkdir/03.short/F03_63000_enhancer.bed -g 63k

		module unload bedtools
	fi
fi
