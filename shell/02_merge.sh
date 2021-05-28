
## step_1 set extend bed files with window size 
for i in `ls /data/BCI-Haemato/Yi/change_bed/03.short/`;do
	python extend.py -b /data/BCI-Haemato/Yi/change_bed/03.short/$i -o /data/BCI-Haemato/Yi/change_bed/04.merge/$i -int 750
done


## step_2 merge three bed files to merged.bed 
module load bedtools
mkdir /data/BCI-Haemato/Yi/change_bed/04.merge/extend
mv /data/BCI-Haemato/Yi/change_bed/04.merge/*bed /data/BCI-Haemato/Yi/change_bed/04.merge/extend

mkdir /data/BCI-Haemato/Yi/change_bed/04.merge/merge
cat /data/BCI-Haemato/Yi/change_bed/04.merge/extend/*bed | sort -k1,1 -k2,2n | bedtools merge -i - -c 4 -o collapse -d 100 > /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge.bed



# step_3 extracted intersect bed and lst
mkdir /data/BCI-Haemato/Yi/change_bed/04.merge/lst

bedtools intersect -a /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge.bed -b /data/BCI-Haemato/Yi/change_bed/04.merge/extend/200k_eRNA_loci.bed -wa -u > /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge_200k.bed

bedtools intersect -a /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge.bed -b /data/BCI-Haemato/Yi/change_bed/04.merge/extend/Annotation_eRNA_300k_enhancer.bed -wa -u > /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge_300k.bed 

bedtools intersect -a /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge.bed -b /data/BCI-Haemato/Yi/change_bed/04.merge/extend/F03_63000_enhancer.bed -wa -u > /data/BCI-Haemato/Yi/change_bed/04.merge/merge/merge_63k.bed


# step_4 create merge list
for i in `ls /data/BCI-Haemato/Yi/change_bed/04.merge/merge/`
do 
	a=${i%%.*}; awk 'BEGIN{print "'$a'"}{print $4}' /data/BCI-Haemato/Yi/change_bed/04.merge/merge/$i > /data/BCI-Haemato/Yi/change_bed/04.merge/lst/$a".lst"
done

# step_5 paste all list
paste /data/BCI-Haemato/Yi/change_bed/04.merge/lst/*lst > /data/BCI-Haemato/Yi/change_bed/04.merge/lst/63k_200k_300k.xls
