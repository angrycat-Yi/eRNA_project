#!/usr/bin/shell

wkdir=$2
window_size=$1


if [ -z $wkdir ];then

	echo "please set the working directory. Example: /data/BCI-Haemato/Yi/analysis/eRNA_project"

elif [ -z $window_size ];then

	echo "please set the window size. Example: 200"

else
	
	echo "pipeline start"
	sh 01_filter.sh $wkdir
	
	echo "step1:filtering completed"
	sh 02_merge.sh $window_size $wkdir

	echo "step2:merge list completed"
	sh 03_extracted_bed.sh $window_size $wkdir
	
	echo "step3:extract bed completed"

fi 
