#12
cut -f 9 gencode.v25.primary_assembly.annotation.gtf | cut -d';' -f 3 | grep "gene_type" | sort | uniq | wc -l



#13 35317500,97283839,36
cat gencode.v25.primary_assembly.annotation.gtf | grep "gene_type \"protein_coding\"" | > protein_coding.gtf 

cat protein_coding.gtf| grep $'CDS\t'  | > CDS.gtf 
convert2bed -i gtf < CDS.gtf > CDS.bed
sort -k1,1 -k2,2n CDS.bed | > CDS_sorted.bed
bedtools merge -i CDS_sorted.bed| > CDS_merged.bed
awk '{sum+=($3 - $2)} END {print sum}' CDS_merged.bed  

cat protein_coding.gtf| grep $'exon\t' | >  exon.gtf
convert2bed -i gtf < exon.gtf > exon.bed
sort -k1,1 -k2,2n exon.bed | > exon_sorted.bed
bedtools merge -i exon_sorted.bed| > exon_merged.bed
awk '{sum+=($3 - $2)} END {print sum}' exon_merged.bed

#14
awk '{print $19"\t"$3 - $2}' exon_sorted.bed |sort -k2.2n | tail -1

#15 176660457/80086=2205.884386784207

cat exon_sorted.bed | grep "gene_type \"protein_coding\"" | grep " transcript_type \"protein_coding\"" | > mrnk.bed
awk '{sum+=($3-$2)} END {print sum}' mrnk.bed
cut -f 10 mrnk.bed | cut -d";" -f 2 | grep transcript_id | sort | uniq | wc -l

