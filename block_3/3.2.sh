# 13 V,21
cat  Caenorhabditis_elegans.WBcel235.dna.toplevel.fa.fai|column -t

# 14

# 15 82553665
awk '{$1 ~ /[IV]/?sum+=$2:sum+=0} END {print sum}' Caenorhabditis_elegans.WBcel235.dna.toplevel.fa.fai


