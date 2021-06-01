#!/usr/bin/sh

window_size=$1
wkdir=$2


if [ -z $window_size ];then
	echo "window size not denfied"

elif [ -z $wkdir ];then
	echo "please set working directory"

else
	mkdir -p $wkdir/05.extracted/$window_size 
	# step_1 63k_200k interaction list 
	awk 'NR==FNR{a[$1]=$1}NR>FNR{if(a[$1]!=""){print a[$1]}else{next}}' $wkdir/04.merge/$window_size/lst/merge_63k.lst $wkdir/04.merge/$window_size/lst/merge_200k.lst > $wkdir/05.extracted/$window_size/63k_200k.lst

	# step_2 63k_300k interaction list
	awk 'NR==FNR{a[$1]=$1}NR>FNR{if(a[$1]!=""){print a[$1]}else{next}}' $wkdir/04.merge/$window_size/lst/merge_63k.lst $wkdir/04.merge/$window_size/lst/merge_300k.lst > $wkdir/05.extracted/$window_size/63k_300k.lst

	# step_3 200k_300k intreaction list
	awk 'NR==FNR{a[$1]=$1}NR>FNR{if(a[$1]!=""){print a[$1]}else{next}}' $wkdir/04.merge/$window_size/lst/merge_200k.lst $wkdir/04.merge/$window_size/lst/merge_300k.lst > $wkdir/05.extracted/$window_size/200k_300k.lst

	# step_4 merge list
	cat $wkdir/05.extracted/$window_size/*lst |sort -u|awk 'FNR==NR{a[$1]=$1}NR>FNR{if(a[$4]!=""){print $0}}' - $wkdir/04.merge/$window_size/merge/merge.bed > $wkdir/05.extracted/$window_size/extracted_$window_size".bed"
	
	# step_5 make gff file
	awk 'BEGIN{print "#!genome-build  GRCh38.p10\n#!genome-version\n#!genome-date   2013-12\n#!genome-build-accession\n#!genebuild-last-updated"}{print $1"\tENCODE\texon\t"$2"\t"$3"\t0\t+\t.\tgene_id=\"ENSR"$1"_"$2"\""}' $wkdir/05.extracted/$window_size/extracted_$window_size".bed" > $wkdir/05.extracted/$window_size/extracted_$window_size".gff"

	awk '{print $1":"$2":"$3}' $wkdir/05.extracted/$window_size/extracted_$window_size".bed" > $wkdir/05.extracted/$window_size/extracted_$window_size"_check.lst"

fi
