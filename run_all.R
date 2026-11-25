# Runs the whole analysis from scratch, in order.
# Every file is saved next to the script/report that made it.
library(here)

source(here("R", "01_data_split.R"))      # -> R/train.rds, R/test.rds
source(here("R", "02_model_training.R"))  # -> R/m_final.rds, R/results.rds

rmarkdown::render(here("reports", "descriptive_report.Rmd"))  # -> reports/descriptive_report.pdf
