# Load required libraries
library(dplyr)

#Read the data from the file
file_homo_sapiens_geneInfo<- "D:/hiring_task/task3/Homo_sapiens.gene_info.gz"
homo_sapiens_gene_info <- read.delim(file_homo_sapiens_geneInfo, header = FALSE, sep = "\t", quote = "", comment.char = "")
print(homo_sapiens_gene_info)

#checking the col names and extracting the required columns for mapping
colnames(homo_sapiens_gene_info)
reqd_cols <-select(homo_sapiens_gene_info,c(V3,V7))

#setting the col names as symbols and chromosome instead of V3 and V7
reqd_cols_new <- reqd_cols                         # Duplicating data frame
colnames(reqd_cols_new) <- reqd_cols[1, ]          # Convert first row to header
reqd_cols_new<-reqd_cols_new[-1,]                  # set first row as null in updated data frame
#View(reqd_cols_new)

#filter rows that contain the string '|' in the chromosome column
#new_cols<-reqd_cols_new %>% filter(grepl('|',reqd_cols_new$chromosome))

#creating a table which shows frequency of each chromosomes
table1 <- table(reqd_cols_new$chromosome)
print(table1)

#converting the table into a dataframe
distribution_gene_count_per_chromosome <-as.data.frame(table1)

#renamed the frst column 
colnames(distribution_gene_count_per_chromosome)[1] <- "Chromosomes"
# colnames(distribution_gene_count_per_chromosome)[2] <- "Gene count"

#discarding the rows which contains chromosomes values as "10|19|3"
#new_distribution_geneCount_chromosome <- distribution_gene_count_per_chromosome %>%filter(!grepl("\\|",distribution_gene_count_per_chromosome$Chromosomes))

new_distribution_geneCount_chromosome <- distribution_gene_count_per_chromosome %>% 
  filter(!grepl("\\|", distribution_gene_count_per_chromosome$Chromosomes)) %>%  # Exclude rows with "|" in the chromosome column
  filter(Chromosomes != "-")            # Exclude rows with "-" in the chromosome column

# Sort the chromosomes in the specified order
#new_distribution_geneCount_chromosome$Chromosomes <- factor(new_distribution_geneCount_chromosome$Chromosomes, levels = c(1:22, "X", "Y", "MT", "Un"))

chromosome_order <- c(as.character(1:22), "X", "Y", "MT", "Un")
new_distribution_geneCount_chromosome$Chromosomes <- factor(new_distribution_geneCount_chromosome$Chromosomes, levels = chromosome_order)


#Arrange the data based on the custom order of chromosomes
new_distribution_geneCount_chromosome <- new_distribution_geneCount_chromosome %>% arrange(Chromosomes)

#Summarize the data by chromosome and gene counts of each chromosome
summarized_data <- new_distribution_geneCount_chromosome %>%
  group_by(Chromosomes) %>%
  summarise(gene_count = sum(Freq))

#plotting graph where x axis the chromosomes number and y axis contains the gene count
library(ggplot2)
# ggplot(new_distribution_geneCount_chromosome, aes(x = Chromosomes)) +
#   geom_bar(fill = "steelblue") +
#   labs(x = "Chromosomes", y = "Gene count", title = "Number of Genes in each Chromosome") +
#   scale_y_continuous(breaks = seq(0, max(new_distribution_geneCount_chromosome$Freq), by = 5000)) +           # Setting custom y-axis breaks
#   theme_minimal()

ggplot(summarized_data, aes(x = Chromosomes, y = gene_count)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(x = "Chromosome", y = "Gene count", title = "Number of Genes in each Chromosome") +
  scale_y_continuous(breaks = seq(0, max(summarized_data$gene_count), by = 5000)) + # Set custom y-axis breaks
  theme_minimal()