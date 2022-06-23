# 10: 0
samtools flagstat Ce_Pol2_sorted.bam  

# 11
wget https://github.com/broadinstitute/picard/releases/download/2.27.1/picard.jar
java -jar picard.jar MarkDuplicates I=Ce_Pol2_sorted.bam O=Ce_Pol2_markdup.bam M=file.metrics

samtools view -b -F 0x400 -q 10 Ce_Pol2_markdup.bam  | >  Ce_Pol2_dedup_q10.bam
samtools index Ce_Pol2_dedup_q10.bam 
samtools idxstats Ce_Pol2_dedup_q10.bam 
samtools idxstats Ce_Pol2_sorted.bam

# 12
wget https://genome.ucsc.edu/cgi-bin/hgTables?hgsid=1371887371_A1n0Ffv1PFR2yz2OnzrAxHR3B9Aw&boolshad.hgta_printCustomTrackHeaders=0&hgta_ctName=tb_rmsk&hgta_ctDesc=table+browser+query+on+rmsk&hgta_ctVis=pack&hgta_ctUrl=&fbQual=whole&fbUpBases=200&fbDownBases=200&hgta_doGetBed=get+BED
mv 'hgTables?hgsid=1371887371_A1n0Ffv1PFR2yz2OnzrAxHR3B9Aw&boolshad.hgta_printCustomTrackHeaders=0&hgta_ctName=tb_rmsk&hgta_ctDesc=table+browser+query+on+rmsk&hgta_ctVis=pack&hgta_ctUrl=&fbQual=whole&fbUpBases=200&fbDownBases=200&hgta_doGet' Dm_RepeatMasker.bed

wget https://genome.ucsc.edu/cgi-bin/hgTables\?hgsid\=1371887371_A1n0Ffv1PFR2yz2OnzrAxHR3B9Aw\&boolshad.hgta_printCustomTrackHeaders\=0\&hgta_ctName\=tb_rmsk\&hgta_ctDesc\=table+browser+query+on+rmsk\&hgta_ctVis\=pack\&hgta_ctUrl\=\&fbQual\=whole\&fbUpBases\=200\&fbDownBases\=200\&hgta_doGetBed\=get+BED -O dm6.bed
cat dm6.bed | grep Dme | grep rRNA | > dm6.rRNA_dme.bed
bedtools merge -i dm6.rRNA_dme.bed | >  dm6.rRNA_merged.bed
# cp ../4.4/4.4.3_4/Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa dm6.fa
#python code
# with open('dm6.fa', 'r') as f:
#     x = f.read()
# x = x.replace('BDGP6:', '')
# with open('dm6_1.fa', 'w') as f:
#     f.write(x)
cat dm6.rRNA_merged.bed | grep 'chr2R\|chr3L\|chr4\|chrX' | grep -v chrX_ | > dm6.rRNA_merged1.bed
# with open('dm6.rRNA_merged1.bed', 'r') as f:
#     x = f.read()
# x = x.replace('BDGP6:', '')
# with open('dm6.rRNA_merged2.bed', 'w') as f:
#     f.write(x)

bedtools getfasta -fi dm6_1.fa -bed dm6.rRNA_merged2.bed | > dm6.rRNA.fa
bowtie2-build dm6.rRNA.fa dm6.rRNA 
bowtie2 -S dm6.rRNA.sam -x dm6.rRNA -U Dm_rnaseq.fastq



# 13  12339374 / 14146207 = 87

cp 3/3.3/plus_dm6.bed 4/4.5/4.5.2/
cp 3/3.3/minus_dm6.bed 4/4.5/4.5.2/
cp 4.4/4.4.3_4/Dm_rnaseq_sorted.bam 4.5/4.5.2/


cat plus_dm6.bed minus_dm6.bed | > exons_dm6.bed
#python code
#>>> with open('exons_dm6.bed', 'r') as f:
#...     x = f.read()
#... 
#>>> x = x.replace('chr', '')
#>>> with open('exons_dm6.bed', 'w') as f:
#...     f.write(x)

samtools view -q 10 Dm_rnaseq_intersect.bam | wc -l  #12339374
samtools view -q 10 Dm_rnaseq_sorted.bam | wc -l     #14146207


# 14 да, "обратный", так как на обратную нить выравнивается на 2 порядка больше

bedtools intersect -abam Dm_rnaseq_sorted.bam -b exons_dm6.bed -s | > Dm_rnaseq_intersect_same_strand.bam
bedtools intersect -abam Dm_rnaseq_sorted.bam -b exons_dm6.bed -S | > Dm_rnaseq_intersect_comp_strand.bam

samtools view -q 10 Dm_rnaseq_intersect_same_strand.bam | wc -l   #439232
samtools view -q 10 Dm_rnaseq_intersect_comp_strand.bam | wc -l   #12201047

# 15 if should be 439232 / 12339374 = 3 :(
