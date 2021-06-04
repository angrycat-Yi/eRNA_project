#!/usr/bin/sh

wkdir=$1

for i in `ls $wkdir/02.filter`
	do echo $i
	cat $wkdir/02.filter/$i|wc -l
done

echo -e "\n" 

for i in `ls $wkdir/01.blacklist/fasta/*fasta`;do 
	echo $i
	ls -l "$i" | awk '{print $5}'
done

echo -e "\n"

for i in `ls $wkdir/04.merge/`
	do echo "size:"$i
	for j in `ls $wkdir/04.merge/$i/merge`
		do echo $j
		cat $wkdir/04.merge/$i/merge/$j|wc -l
	done
	echo "------"
done
