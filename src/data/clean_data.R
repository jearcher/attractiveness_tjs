# Use data.table syntax, dplyrs library
library(data.table)
library(tidyverse)


###################################################################
# Ensure directory is './src/data/'. If in RStudio run this line: #

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

###################################################################
# Read in interim data (fixed mislabeled data)
data <- fread("../../data/interim/data_block_A_fixed.csv")

# Fix column naming error
setnames(data, "swipe_6c_f_d", "swipe6_c_f_d")

# First two columns are not observations 
# (Why this has to be done twice instead of data[-2,] is beyond me)
data <- data[-1,]
data <- data[-1,]

# Subset only the columns we need (to save space)
cols2keep <- colnames(data)[c(9, 19:364)]
data <- subset(data, select =  cols2keep)

data[ , ]

# Write to processed\
fwrite(data, file = "../../data/processed/processed_data.csv")



# get all colnames that contain 'swipe'
swipe_cols <- colnames(data)[grepl(pattern = "swipe", x = colnames(data))]
swipe_data <- subset(data, select = swipe_cols)

swipes_phys_cols <- colnames(swipe_data)[grepl(pattern = "phys_", x = colnames(swipe_data))]
swipes_person_cols <- colnames(swipe_data)[grepl(pattern = "person_", x = colnames(swipe_data))]

swipe_phys <- subset(swipe_data, select = swipes_phys_cols)
swipe_person <- subset(swipe_data, select = swipes_person_cols)

swipe_only_cols <- colnames(swipe_data)[!grepl(pattern = "phys_", x = colnames(swipe_data)) & !grepl(pattern = "person_", x = colnames(swipe_data))]
swipe_only <- subset(swipe_data, select = swipe_only_cols)

swipe_only_control_cols <- colnames(swipe_only)[grepl(pattern = "_c_", x = colnames(swipe_only))]
swipe_only_treatment_cols <- colnames(swipe_only)[grepl(pattern = "_t_", x = colnames(swipe_only))]

swipe_only_ctrl <- subset(swipe_only, select = swipe_only_control_cols)
swipe_only_treat <- subset(swipe_only, select = swipe_only_treatment_cols)



#############################################################################
# sink() calls to print output of Hmisc::describe() (pdf summaries of vars) #
#############################################################################
library(Hmisc)
treatment_summary <- Hmisc::describe(swipe_only_treat)
control_summary <- Hmisc::describe(swipe_only_ctrl)

sink("../../reports/treatment_summary.txt")
Hmisc::latex(treatment_summary,
             file = "")
sink()


sink("../../reports/control_summary.txt")
Hmisc::latex(control_summary,
             file = "")
sink()

# Reorder swipe_only to alternate treatment and control (makes viewing summaries easier)
setcolorder(swipe_only, neworder = c(rbind(swipe_only_control_cols, swipe_only_treatment_cols)))

total_summary <-  Hmisc::describe(swipe_only)
sink("../../reports/treat_control_summary.txt")
Hmisc::latex(total_summary,
             file = "")
sink()

##########################
# Create new data tables #
##########################


