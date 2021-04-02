# Use data.table syntax, dplyrs library
library(data.table)
library(dplyr)
library(tidyverse)
# Ensure the directory is "./src/data"
data <- fread("../../data/raw/raw_survey_data_main.csv")

# First two columns are not observations 
# (Why this has to be done twice instead of data[-2,] is beyond me)
data <- data[-1,]
data <- data[-1,]


# Write to interim until finished

fwrite(data, file = "../../data/interim/interim_data.csv")
