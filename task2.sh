#!/bin/bash

# Download the protein FASTA file
#wget -qO NC_000913.faa.gz https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr__MG1655_uid57779/NC_000913.faa.gz

# Unzip the downloaded file
#zcat NC_000913.faa.gz > NC_000913.faa
#already downloaded in my local folder

# Count the number of sequences in the file
count_sequences=$(grep -c '^>' NC_000913.faa)
echo "Number of sequences in the file: $count_sequences"

# Total number of amino acids in the file
count_aminoacids=$(grep -v '^>' NC_000913.faa | tr -d '\n' | wc -c)
echo "Number of amino acids in the file: $count_aminoacids"

# Calculate the average length of protein in this strain
avg_length_protein=$(echo "scale=2; $count_aminoacids / $count_sequences" | bc)
echo "Average length of protein in this strain: $avg_length_protein"



