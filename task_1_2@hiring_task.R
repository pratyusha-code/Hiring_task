#TASK 1
# Load required libraries
library(dplyr)

#Read the data from the file
file_path <- "D:/hiring_task/Homo_sapiens.gene_info.gz"
homo_sapiens_gene_info <- read.delim(file_path, header = FALSE, sep = "\t", quote = "", comment.char = "")
print(homo_sapiens_gene_info)

#checking the col names and extracting the required columns for mapping
colnames(homo_sapiens_gene_info)
reqd_cols <-select(homo_sapiens_gene_info,c(V2,V3,V5))

#setting the col names as Geneid,symbols and synomyms instead of V2,V3 and V5
reqd_cols_new <- reqd_cols                         # Duplicating data frame
colnames(reqd_cols_new) <- reqd_cols[1, ]          # Convert first row to header
reqd_cols_new<-reqd_cols_new[-1,]                  # set first row as null in updated data frame
#View(reqd_cols_new)


# Splitting the synonyms based on the "|" character
gene_names_extract <- strsplit(reqd_cols_new$Synonyms, "\\|")

# Convert the list of character vectors to a single character vector
all_gene_names <- unlist(gene_names_extract)

# Remove leading/trailing whitespaces
all_gene_names <- trimws(all_gene_names)

# Filter out empty or NA values
final_gene_names <- all_gene_names[!is.na(all_gene_names) & all_gene_names != ""]

# Print the extracted gene names
print(final_gene_names)

# now adding the extracted gene names to the Symbol column
reqd_cols_new1<- reqd_cols_new %>%
  mutate(Symbol = ifelse(row_number() <= length(final_gene_names), final_gene_names, Symbol))

# Print the updated data frame
print(reqd_cols_new1)

# Create a data frame to represent the mapping
mapping_symbol_geneID <- data.frame(reqd_cols_new1$Symbol, reqd_cols_new1$GeneID)

# Print the mapping data frame
print(mapping_symbol_geneID)

#TASK 2
#read the gmt file and extract the all the gene names from this
gmt_file <- "D:/hiring_task/h.all.v2023.1.Hs.symbols.gmt"  # Replace with the actual file name or path
gmt_lines <- readLines(gmt_file)

extract_lines <- vector("list", length(gmt_lines))

#extracting the gene names from gmt file
for (i in seq_along(gmt_lines)) 
{
  line <- gmt_lines[i]
  fields <- strsplit(line, "\t")[[1]]
  
# Extract pathway name and description
pathway_name <- fields[1]
pathway_description <- fields[2]
  
#Extract gene names excluding the first two fields (pathway name and description)
gene_names <- fields[-c(1, 2)]

# Store gene names in the gene names list(extract_lines)
extract_lines[[i]] <- gene_names

# Replacing gene names with Gene/Entrez IDs using the gene_info data lookup table

# Extract gene names excluding the first two fields (pathway name and description)
#gene_names <- fields[-c(1, 2)]

gene_ids <- character(length(gene_names))
for (j in seq_along(gene_names)) 
  {
  gene_name <- gene_names[j]
  match_row <- which(mapping_symbol_geneID$reqd_cols_new1.Symbol == gene_name)
  
  if (length(match_row) > 0) 
    {
    gene_ids[j] <- mapping_symbol_geneID$reqd_cols_new1.GeneID[match_row[1]]
    } 
  else 
    {
    gene_ids[j] <- NA  # If gene name not found in the reqd_cols_new1 put NA,no match
    }
  }

# Store the processed lines with gene/Entrez IDs
extract_lines[[i]] <- c(pathway_name, pathway_description, gene_ids)
}

#Convert the extracted lines to a data frame with varying column lengths

#processed_df <- as.data.frame(do.call(rbind, extract_lines), stringsAsFactors = FALSE)

max_cols <- max(lengths(extract_lines))
print(max_cols)

#replacing the shorter rows with NA values to match with the max cols
padded_lines <- lapply(extract_lines, function(row) {
  if (length(row) < max_cols) {
    c(row, rep(NA, max_cols - length(row)))
  } else {
    row
  }
})

#data_frame <- as.data.frame(do.call(rbind, padded_lines))
processed_df <- as.data.frame(do.call(rbind, padded_lines))


# setting column names
colnames(processed_df) <- c("PathwayName", "PathwayDescription", paste0("EntrezID_", seq_len(ncol(processed_df) - 2)))
#colnames(data_frame) <- c("PathwayName", "PathwayDescription", paste0("EntrezID_", seq_len(ncol(processed_df) - 2)))

# Print the resulting data frame
print(processed_df)

#copying dataframe to another 
processed_df_1<-processed_df

#removing column names to write in the GMT file properly
colnames(processed_df_1) <- NULL

# Specify the output GMT file name
output_gmt_file_name <- "processed_output.gmt"

# Write the processed data frame to the GMT file
write.table(processed_df_1, file = output_gmt_file_name, sep = "\t", row.names = FALSE, quote = FALSE)
