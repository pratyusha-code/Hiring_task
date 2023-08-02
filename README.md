# Hiring_task 
Hiring task 2023@Malay Basu

Table of contents:-

      1 Task 
      
      2 Data
      
      3 Specification
      
      4 Rules 


1. 
      Task 1
   
      You need to write a computer program that takes a GMT file as an input and replace the gene names (or symbol)
      in the file with Entrez Ids that effectively creates another GMT file with Entrez ID.
      Entrez ID (or gene ID) is a unique number that is given to any gene in the NCBI Entrez database. A GMT file
      is a tab-delimited text file (columns are separated by tabs). These files are used in pathway analysis. The file
      format is described in the data section below.

      Task 2
   
      E. coli MG1655 is the standard reference strain of E. coli. The protein FASTA file for this strain can be
      downloaded from https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_
      12_substr__MG1655_uid57779/NC_000913.faa. Using just bash commands can you find out what is the
      average length of protein in this strain? You may use as many commands as you may wish.

      Task 3
   
      Use R and ggplot2 package draw a a plot of number of genes per chromosome in human genomes. This task
      requires the data file Homo_sapiens.gene.info.gz. You need to use columns 3 and 7 indicating Symbol and
      chromosome respectively. You script should create a plot exactly as shown below. Save the plot to PDF file.

3.
   Data- for task 1
  
      There are two files you need to complete this task. The files may have been compressed using gzip software.
      Preferably, you should not unzip these files at all. Most modern computer languages should be able to read
      these files as it is.
  
   1. Homo_sapiens.gene_info.gz . This is a tab-delimited text file that contains information about all the
   genes in the human genome. The file contains a lot of information, but we are interested in only the
   following columns: 2, 3, 5. These are GeneID (Entrez Id), Symbol and Synonyms. Create a mapping
   of Symbol to GeneId. You have to be particularly careful about the Synonym column which may have
   multiple Symbol names separated by |. Like this AACT|ACT|GIG24|GIG25. You need to extract the
   individual gene names from this column add them to the Symbol to GeneId map. If you are interested
   in more about this file format check here: https://ftp.ncbi.nih.gov/gene/DATA/README.
   
   2. h.all.v2023.1.Hs.symbols.gmt. This is a gene matrix transposed file. This is a tab-delimited text file.
   This type of file is used for pathway analysis. It is a very simple file format, however, each line can be of
   different lengths. This file, therefore, should be read line by line, not by columns. If you split each line on
   tab, it will create a number of values (or fields). The first two values are “pathway name" and”pathway
   description". All subsequent values are gene names that belong to the particular pathway. Your goal
   is to replace the gene names with Entrez ID extracted from the first “gene_info” file.
      
      Data-for task 2
      
      NC_000913.faa.gz is a amino acid FASTA file compressed using gzip. You download the same file from
      here: https://ftp.ncbi.nlm.nih.gov/genomes/archive/old_refseq/Bacteria/Escherichia_coli_K_12_substr_
      _MG1655_uid57779/NC_000913.faa
  
      Note:
      1. You must use only bash commands. No other programming language is allowed. If you are using Mac
      or Linux, then bash automatically comes along with the machine. For windows you need to install
      bash. Follow the instructions here: https://superuser.com/questions/608106/how-can-i-use-a-bashlike-shell-on-windows.
      2. You can either provide a single command line or a bash script.
      3. You may need the following commands in bash to complete this task: wget, zcat, wc, tr, bc,
      and grep. You are not restricted to any of these commands. You can use any or all or any other bash
      commands in your script or command line.
      4. Save your command or bash script as task2.sh.
      5. Hint: you need to count the number of sequences in the file and the total number of amino acids then
      divide the latter with the former. The answer is 316
      
      Data for task 3
      
      Homo_sapiens.gene_info.gz . This is a tab-delimited text file that contains information about all the genes
      in the human genome. If you are interested in more about this file format check here: https://ftp.ncbi.nih.
      gov/gene/DATA/README.

      Note:
      1. The figure should exactly look like the above figure.
      2. There are some data in the chromosome column that are ambiguous and look like this: 10|19|3. You
      need to discard all rows where the chromosome value contains a |

3. Specification for task 1-
   1. Your program should read the gene_info file and create a unique mapping of all gene (symbol) names
   to their corresponding Entrez ID. You need to be comprehensive to include all symbols both including
   those in the Synonyms and Symbol columns.
   2. Read GMT file and proceed to the next step.
   3. Write a file (or print in the terminal) a new GMT file where symbols have been replaced with Entrez IDs.
   
4. Rules-
   1. You have 48 hours to finish the task.
   2. You can use any computer language of your choice. However, you get bonus points for finishing this task in R.
   3. Strictly follow the submission instruction. The only way your submission is accepted is through a GitHub link. No other way of submission is admissible.
   4. All program must be a stand-alone script, runnable from the command line. No Jupyter, iPython notebook, or Rmarkdown allowed.
   5. Strictly follow the submission instruction. The only way your submission is accepted is through a
      GitHub link. No other way of submission is admissible.

