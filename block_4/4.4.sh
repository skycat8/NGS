# 11
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3535767/SRR3535767.1
fastq-dump --split-3 SRR3535767.1
mv SRR3535767.1.fastq Ce_Pol2.fastq

bowtie2-build ce_ens_86.fa ce_ens_86
bowtie2 -S Ce_Pol2.sam -x ce_ens_86 -U Ce_Pol2.fastq

# 12
samtools view -b Ce_Pol2.sam -o Ce_Pol2.bam
samtools sort Ce_Pol2.bam -o Ce_Pol2_sorted.bam
samtools index Ce_Pol2_sorted.bam

# 807572 / 2529958
#?????? 39 insted of 42
cut -f 5 Ce_Pol2.sam | sort -k1.2n  | tail -1
samtools view -q 42 Ce_Pol2_sorted.bam | cut -f 1 | sort | uniq | wc -l
samtools view  Ce_Pol2_sorted.bam | cut -f 1 | sort | uniq | wc -l


# 13
gunzip Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa.gz
samtools faidx Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa 

wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos1/sra-pub-run-1/SRR3146648/SRR3146648.1
fastq-dump --split-3 SRR3146648.1 
mv SRR3146648.1.fastq Dm_rnaseq.fastq
hisat2-build Drosophila_melanogaster.BDGP6.dna_sm.toplevel.fa Drosophila_melanogaster.BDGP6.dna_sm.toplevel
hisat2 -S Dm_rnaseq.sam -x Drosophila_melanogaster.BDGP6.dna_sm.toplevel -U Dm_rnaseq.fastq 


# 14

samtools view -b Dm_rnaseq.sam -o Dm_rnaseq.bam
samtools sort Dm_rnaseq.bam -o Dm_rnaseq_sorted.bam
samtools index Dm_rnaseq_sorted.bam

samtools view Dm_rnaseq_sorted.bam | cut -f 6 | grep ".M[^N]*" | grep -o "[0-9]*N" | grep -o "[0-9]*" | sort -n | tail -1


# 15 

samtools view Dm_rnaseq_sorted.bam | cut -f 5 | sort | uniq
samtools view -q 10 Dm_rnaseq_sorted.bam | cut -f 1 | sort | uniq |wc -l
samtools view Dm_rnaseq_sorted.bam | grep M | cut -f 1 | sort | uniq |wc -l



wget https://cloud.biohpc.swmed.edu/index.php/s/oTtGWbWjaxsQ2Ho/download

