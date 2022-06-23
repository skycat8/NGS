# 9
blastn -db nt -query blastn.fa -outfmt "6 qacc sacc evalue qstart qend sstart send sblastnames scomnames sscinames" -out results.out -remote

# 11

fastq-dump --split-3 ERR426367.1 
mv ERR426367.1_1.fastq Legionella_R1.fastq
mv ERR426367.1_2.fastq Legionella_R2.fastq 
sed '/^@/!d;s//>/;N' Legionella_R1.fastq > Legionella_R1.fa
wget https://ftp.ncbi.nlm.nih.gov/pub/UniVec/UniVec
sudo apt-get install ncbi-blast+
makeblastdb -in UniVec -parse_seqids -dbtype nucl 
blastn -db UniVec -reward 1 -penalty -5 -gapopen 3 -gapextend 3 -dust yes -soft_masking true -evalue 700 -searchsp 1750000000000 -query Legionella_R1.fa -outfmt 6 -out file.format6.out
awk -F '\t' '{print $2}' file.format6.out | sort | uniq -c | sort -nr | head -3
cat UniVec | grep NGB00819.1:1-63 
#>gnl|uv|NGB00819.1:1-63 Illumina TruSeq Small RNA Sample Prep Kit RNA PCR Primer Index 26 (RPI26) (Oligonucleotide sequence copyright 2007-2012 Illumina, Inc. All rights reserved.)
cat UniVec | grep NGB00738.1:1-47 
#>gnl|uv|NGB00738.1:1-47 Illumina Nextera PCR primer i7 index N704 (Oligonucleotide sequence copyright 2007-2012 Illumina, Inc. All rights reserved.)
cat UniVec | grep NGB00726.1:1-34
#>gnl|uv|NGB00726.1:1-34 Illumina Nextera transposase sequence Read 2 (Oligonucleotide sequence copyright 2007-2012 Illumina, Inc. All rights reserved.)
