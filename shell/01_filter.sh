module load bedtools

## step_1 create black list
mkdir /data/BCI-Haemato/Yi/change_bed/01.blacklist
cat /data/BCI-Haemato/Yi/change_bed/01.blacklist/blacklist_biomart.txt /data/BCI-Haemato/Yi/change_bed/01.blacklist/blacklist_rmsk_ch.txt /data/BCI-Haemato/Yi/change_bed/01.blacklist/non_coding.bed | sort -k1,1 -k2,2n | bedtools merge -i - -c 4 -o collapse -d 6000 > /data/BCI-Haemato/Yi/change_bed/01.blacklist/black_list.bed


## step_2 exclude the black_list
mkdir /data/BCI-Haemato/Yi/change_bed/02.filter  
bedtools subtract -a /data/BCI-Haemato/Yi/change_bed/extend/200k_eRNA_loci_ext.bed -b /data/BCI-Haemato/Yi/change_bed/01.blacklist/black_list.bed > /data/BCI-Haemato/Yi/change_bed/02.filter/200k_eRNA_loci_fl.bed

bedtools subtract -a /data/BCI-Haemato/Yi/change_bed/extend/Annotation_eRNA_300k__enhancer.bed -b /data/BCI-Haemato/Yi/change_bed/01.blacklist/black_list.bed > /data/BCI-Haemato/Yi/change_bed/02.filter/Annotation_eRNA_300k_enhancer_fl.bed

bedtools subtract -a /data/BCI-Haemato/Yi/change_bed/extend/F03_63000_enhancer_ext.bed -b /data/BCI-Haemato/Yi/change_bed/01.blacklist/black_list.bed > /data/BCI-Haemato/Yi/change_bed/02.filter/F03_63000_enhancer_fl.bed


## step_3 shorten the bed files to 1bp
mkdir /data/BCI-Haemato/Yi/change_bed/03.short
python /data/BCI-Haemato/Yi/change_bed/shell/short.py -f /data/BCI-Haemato/Yi/change_bed/02.filter/200k_eRNA_loci_fl.bed -o /data/BCI-Haemato/Yi/change_bed/03.short/200k_eRNA_loci.bed -g 200k
python /data/BCI-Haemato/Yi/change_bed/shell/short.py -f /data/BCI-Haemato/Yi/change_bed/02.filter/Annotation_eRNA_300k_enhancer_fl.bed -o /data/BCI-Haemato/Yi/change_bed/03.short/Annotation_eRNA_300k_enhancer.bed -g 300k
python /data/BCI-Haemato/Yi/change_bed/shell/short.py -f /data/BCI-Haemato/Yi/change_bed/02.filter/F03_63000_enhancer_fl.bed -o /data/BCI-Haemato/Yi/change_bed/03.short/F03_63000_enhancer.bed -g 63k

module unload bedtools
