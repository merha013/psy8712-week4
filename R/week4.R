# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
str(import_tbl)
wide_tbl <- separate_wider_delim(import_tbl, qs, delim=" - ", names = c("q1", "q2", "q3", "q4", "q5"))
wide_tbl <- sapply(wide_tbl(c("q1", "q2","q3", "q4", "q5")), as.integer)
