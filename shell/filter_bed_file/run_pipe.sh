#!/usr/bin/shell

wkdir=$3
merge_size=$2
window_size=$1


if [ -z $wkdir ];then

	echo -e "please set the working directory.\nExample: sh run_pipe.sh [windowsize] [merge_size] /data/BCI-Haemato/Yi/analysis/eRNA_project\nmerge_size: black_list merge size\nwindowsize: enhancer merge size"

elif [ -z $window_size ];then

	echo -e "please set the window size.\nExample: sh run_pipe.sh sh run_pipe.sh [windowsize] [merge_size] /data/BCI-Haemato/Yi/analysis/eRNA_project\nmerge_size: black_list merge size\nwindowsize: enhancer merge size"

else
	
	echo "pipeline start"
	sh 01_filter.sh $wkdir $merge_size
	
	echo "step1:filtering completed"
	sh 02_merge.sh $window_size $wkdir

	echo "step2:merge list completed"
	sh 03_extracted_bed.sh $window_size $wkdir
	
	echo "step3:extract bed completed"

fi 
