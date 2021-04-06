# Use data.table syntax, dplyrs library
library(data.table)
library(tidyverse)
# Ensure the directory is "./src/data"
# Read in interim data (fixed mislabeled data)
data <- fread("../../data/interim/data_block_A_fixed.csv")

# First two columns are not observations 
# (Why this has to be done twice instead of data[-2,] is beyond me)
data <- data[-1,]
data <- data[-1,]

# Subset only the columns we need (to save space)
cols2keep <- colnames(data)[c(9, 19:364)]
data <- subset(data, select =  cols2keep)


# Write to processed\
fwrite(data, file = "../../data/processed/processed_data.csv")




