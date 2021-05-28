#!/usr/bin/shell

window_size=$1
wkdir=$2

if [ -z $window_size ];then

	echo "please set the window size"

elif [ -z $wkdir ];then

	echo "please set the working directory"

else
	
	mkdir -p $wkdir/04.merge/$window_size

	## step_1 set extend bed files with window size 
	for i in `ls $wkdir/03.short/`;do
		python extend.py -b $wkdir/03.short/$i -o $wkdir/04.merge/$window_size/$i -int $window_size
	done


	## step_2 merge three bed files to merged.bed 
	module load bedtools
	mkdir $wkdir/04.merge/$window_size/extend
	mv $wkdir/04.merge/$window_size/*bed $wkdir/04.merge/$window_size/extend

	mkdir $wkdir/04.merge/$window_size/merge
	cat $wkdir/04.merge/$window_size/extend/*bed | sort -k1,1 -k2,2n | bedtools merge -i - -c 4 -o collapse -d 100 > $wkdir/04.merge/$window_size/merge/merge.bed


	# step_3 extracted intersect bed and lst
	mkdir $wkdir/04.merge/$window_size/lst

	bedtools intersect -a $wkdir/04.merge/$window_size/merge/merge.bed -b $wkdir/04.merge/$window_size/extend/200k_eRNA_loci.bed -wa -u > $wkdir/04.merge/$window_size/merge/merge_200k.bed

	bedtools intersect -a $wkdir/04.merge/$window_size/merge/merge.bed -b $wkdir/04.merge/$window_size/extend/Annotation_eRNA_300k_enhancer.bed -wa -u > $wkdir/04.merge/$window_size/merge/merge_300k.bed 

	bedtools intersect -a $wkdir/04.merge/$window_size/merge/merge.bed -b $wkdir/04.merge/$window_size/extend/F03_63000_enhancer.bed -wa -u > $wkdir/04.merge/$window_size/merge/merge_63k.bed


	# step_4 create merge list
	for i in `ls $wkdir/04.merge/$window_size/merge/`
	do 
		a=${i%%.*}; awk 'BEGIN{print "'$a'"}{print $4}' $wkdir/04.merge/$window_size/merge/$i > $wkdir/04.merge/$window_size/lst/$a".lst"
	done

	# step_5 paste all list
	paste $wkdir/04.merge/$window_size/lst/*lst > $wkdir/04.merge/$window_size/lst/63k_200k_300k.xls
fi
