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

# Write to processed
fwrite(data, file = "../../data/processed/processed_data.csv")


##########################
# Create new data tables #
##########################

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

## ??TODO?? 
# - print all distinct values for each treatment choice (swipe only)
# - fix any situation manually where there was only 1 distinct treatment choice
# - append the missing choice from control as the 'losing' choice in control 

# - Double check list on all_phot_choices to manually add when only 1 photo was selected in treatment
# - remove first row

treat_photo_choices <- fread("../../data/interim/treat_photo_choices_incomplete.csv")

ctrl_photo_choices <- copy(treat_photo_choices)
ctrl_photo_choices[, "choice_1" := gsub(pattern = 'nike', replacement = 'none', x = ctrl_photo_choices[, choice_1])]
ctrl_photo_choices[, "choice_1" := gsub(pattern = 'tjs', replacement = 'none', x = ctrl_photo_choices[, choice_1])]

ctrl_photo_choices[, choice_2 := gsub(pattern = 'nike', replacement = 'none', x = ctrl_photo_choices[, choice_2])]
ctrl_photo_choices[, choice_2 := gsub(pattern = 'tjs', replacement = 'none', x = ctrl_photo_choices[, choice_2])]

colnames(ctrl_photo_choices)
View(ctrl_photo_choices)
View(swipe_only)

column1 <- swipe_only[, .(count = .N, var = unique(swipe1_c_m_a), by = swipe1_c_m_a)]
column1


##############
# JA Scratch #
##############
test <- count(swipe_only, swipe1_c_m_a, sort = TRUE)[swipe1_c_m_a != ""]
test_winner <- dplyr::count(swipe_only, swipe1_c_m_a, sort = TRUE)[2]
test_loser <- dplyr::count(swipe_only, swipe1_c_m_a, sort = TRUE)[3]

count(swipe_only)
question <- c()
winning_choice <- c()
losing_choice <- c()

for (i in names(swipe_only)) {
  swipe_only %>% count(i)
}


for (i in 1:length(names(swipe_only))) {
  question <- c(question, i)
  print("okay")
  tmp_colname <- names(swipe_only)[i]
  print("okay2")
  tmp_dt <- swipe_only[tmp_colname]
  winning_choice <- c(winning_choice, count(tmp_dt, tmp_colname, sort = TRUE)[2])
  losing_choice <- c(losing_choice, count(tmp_dt, tmp_colname, sort = TRUE)[3])
}

length(names(swipe_only))


names(swipe_only)[1]
cbind(question, winning_choice, losing_choice)
swipe_only[,1]
names(swipe_only)[1]
test_winner <- count(swipe_only[,1],  sort = TRUE)



swipe_only[ , lapply(.SD, sum)]  # Modify data

for (i in swipe_only[1]) {
  table(swipe_only[,i])
}
table(swipe_only[,1])

fwrite(swipe_only, file = "../../data/interim/swipe_only.csv")
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




