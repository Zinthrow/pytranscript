if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(c("affy", "affyPLM", "hgu133plus2.db"))

library(affy)

# Set the working directory to where your CEL files are stored
setwd("cel_files")

# Read CEL files
data <- ReadAffy()

library(affyPLM)

# Quality assessment
qc <- affyPLM(data)

# Generate QC plots (optional but recommended)
pdf("../qc_report.pdf")
plot(qc)
dev.off()

# Perform RMA normalization
data.rma <- rma(data)

# Get expression values
exprs_data <- exprs(data.rma)

# Convert to a data frame
exprs_df <- as.data.frame(exprs_data)

library(hgu133plus2.db)

# Map probes to gene symbols
probe_ids <- rownames(exprs_df)
gene_symbols <- mapIds(hgu133plus2.db, 
                       keys=probe_ids, 
                       column="SYMBOL", 
                       keytype="PROBEID", 
                       multiVals="first")

# Add gene symbols to the data frame
exprs_df$Gene_Symbol <- gene_symbols

# Save the data
write.csv(exprs_df, "merged_expression_data.csv")

