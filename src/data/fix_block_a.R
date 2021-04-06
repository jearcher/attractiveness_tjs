library(data.table)
library(tidyverse)

data <- fread("../../data/raw/raw_survey_data_main.csv")


# Ensure no mislabeled logos in Block A Control
data[, swipe1_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe1_c_m_a])]
data[, swipe1_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe1_c_m_a])]

data[, swipe2_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe2_c_m_a])]
data[, swipe2_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe2_c_m_a])]

data[, swipe3_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe3_c_f_a])]
data[, swipe3_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe3_c_f_a])]

data[, swipe4_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe4_c_f_a])]
data[, swipe4_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe4_c_f_a])]

data[, swipe5_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe5_c_f_a])]
data[, swipe5_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe5_c_f_a])]

data[, swipe6_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe6_c_m_a])]
data[, swipe6_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe6_c_m_a])]

data[, swipe7_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe7_c_f_a])]
data[, swipe7_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe7_c_f_a])]

data[, swipe8_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe8_c_m_a])]
data[, swipe8_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe8_c_m_a])]

data[, swipe9_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe9_c_m_a])]
data[, swipe9_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe9_c_m_a])]

data[, swipe10_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe10_c_f_a])]
data[, swipe10_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe10_c_f_a])]

data[, swipe11_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe11_c_m_a])]
data[, swipe11_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe11_c_m_a])]

data[, swipe12_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe12_c_f_a])]
data[, swipe12_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe12_c_f_a])]

data[, swipe13_c_f_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe13_c_f_a])]
data[, swipe13_c_f_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe13_c_f_a])]

data[, swipe14_c_m_a := gsub(pattern = 'nike', replacement = 'none', x = data[, swipe14_c_m_a])]
data[, swipe14_c_m_a := gsub(pattern = 'tjs', replacement = 'none', x = data[, swipe14_c_m_a])]


# Write to interim folder
fwrite(data, file = "../../data/interim/data_block_A_fixed.csv")
