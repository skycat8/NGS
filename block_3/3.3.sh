# 7 

# 12
cut -f 4 dm6_refseq.bed | grep NR_ | sort | uniq | wc -l
cut -f 4 dm6_refseq.bed | grep NM_ | sort | uniq | wc -l

#13
bedtools bed12tobed6 -i dm6_refseq.bed > dm6_6.bed
cut -f 6 dm6_6.bed | grep + | wc -l
cut -f 6 dm6_6.bed | grep - | wc -l
cut -f 6 dm6_6.bed | wc -l  

#14

cat dm6_6.bed | grep - | > minus_dm6.bed
cat dm6_6.bed | grep + | > plus_dm6.bed
bedtools intersect -a plus_dm6.bed -b minus_dm6.bed | > intersected_dm6.bed
sort -k1,1 -k2,2n intersected_dm6.bed| > sorted_dm6.bed
bedtools merge -i sorted_dm6.bed| > merged.bed 
awk '{sum+=$3} END {print sum}' merged.bed
awk '{sum+=$2} END {print sum}' merged.bed
