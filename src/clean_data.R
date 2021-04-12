# Use data.table syntax, dplyrs library
library(data.table)
library(tidyverse)


###################################################################
# Ensure directory is './src/data/'. If in RStudio run this line: #

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

###################################################################
# Read in interim data (fixed mislabeled data)
data <- fread("../data/interim/data_block_A_fixed.csv")

# Read in data from JL pythin notebook
swipe_counts <- fread('../data/interim/swipe_counts.csv')

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

treat_photo_choices <- fread("../data/interim/treat_photo_choices_incomplete.csv")

ctrl_photo_choices <- copy(treat_photo_choices)
ctrl_photo_choices[, "choice_1" := gsub(pattern = 'nike', replacement = 'none', x = ctrl_photo_choices[, choice_1])]
ctrl_photo_choices[, "choice_1" := gsub(pattern = 'tjs', replacement = 'none', x = ctrl_photo_choices[, choice_1])]

ctrl_photo_choices[, choice_2 := gsub(pattern = 'nike', replacement = 'none', x = ctrl_photo_choices[, choice_2])]
ctrl_photo_choices[, choice_2 := gsub(pattern = 'tjs', replacement = 'none', x = ctrl_photo_choices[, choice_2])]

ctrl_photo_choices[, question := gsub(pattern="_t_", replacement = '_c_', x=ctrl_photo_choices[, question])]

fwrite(swipe_only, file = "../../data/interim/swipe_only.csv")


##############
# JA Scratch #
##############
swipe_counts <- fread("../data/interim/swipe_counts.csv")

#######################################
# There are winners and losers,       #
# But I truly am the loser            #
# for the next couple hundred lines.  #
#######################################
winner	 <- t(count(swipe_only,	swipe1_c_m_a	, sort = TRUE)[2,1])
winner	<- rbind(winner, t(count(swipe_only,	swipe2_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_c_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_c_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_t_f_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_t_m_a	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_c_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_c_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_t_f_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_t_m_b	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_c_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_c_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_t_f_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_t_m_c	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_c_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_c_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe1_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe2_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe3_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe4_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe5_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe6_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe7_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe8_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe9_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe10_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe11_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe12_t_f_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe13_t_m_d	, sort = TRUE)[2,1]))
winner	<- rbind(winner, t(count(swipe_only,	swipe14_t_m_d	, sort = TRUE)[2,1]))

winner <- data.table(winner)
setnames(winner, "V1", "winner")

swipe_counts <- cbind(swipe_counts, winner)
setnames(swipe_counts, "V1", "question")


View(treat_photo_choices)
swipe_cts_treat_choice <- merge(swipe_counts, treat_photo_choices, by="question")
swipe_cts_ctrl_choices <- merge(swipe_counts, ctrl_photo_choices, by="question")

swipe_cts_choices <- rbind(swipe_cts_ctrl_choices, swipe_cts_treat_choice)

# time to do some manual changes
fwrite(swipe_cts_choices, file = "../data/interim/swipe_winner_unfixed.csv")

### Magic of Excel took remarkably less time than Stack Overflow black hole ##

# Bring it back
swipe_winlose_counts <- fread("../data/interim/swipe_winner_loser_counts.csv")
#####################################
# Indicators for winner smile, logo #
#####################################
# smile 1=yes
swipe_winlose_counts[, winner_smile := ifelse(test = grepl(pattern = "_smile", swipe_winlose_couts[, winner]),
                                              yes = 1, no = 0)]
# tjs 1=yes
swipe_winlose_counts[, winner_tjs := ifelse(test = grepl(pattern = "_tjs", swipe_winlose_couts[, winner]),
                                              yes = 1, no = 0)]
# nike 1=yes
swipe_winlose_counts[, winner_nike := ifelse(test = grepl(pattern = "_nike", swipe_winlose_couts[, winner]),
                                            yes = 1, no = 0)]
# none 1=yes
swipe_winlose_counts[, winner_none := ifelse(test = grepl(pattern = "_none", swipe_winlose_couts[, winner]),
                                             yes = 1, no = 0)]
# man 1= yes
swipe_winlose_counts[, winner_man := ifelse(test = grepl(pattern = "_m_", swipe_winlose_couts[, winner]),
                                            yes = 1, no = 0)]
                                             
better_be_ones <- sum(swipe_winlose_counts[(winner_tjs)],
                      swipe_winlose_counts[(winner_nike)],
                      swipe_winlose_counts[(winner_none)])

# Check that every winning photo is assigned 1 and only 1 logo
swipe_winlose_counts[, better_be_ones := rowSums(.SD), .SDcols = c('winner_tjs', 'winner_nike', 'winner_none')]

fwrite(swipe_winlose_counts, file = "../data/processed/main_swipe_table.csv")

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




