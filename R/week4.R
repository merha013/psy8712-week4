# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- separate_wider_delim(import_tbl, qs, delim = " - ", names = c("q1", "q2", "q3", "q4", "q5"))
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], as.integer)
wide_tbl$datadate <- lubridate::as_datetime(wide_tbl$datadate, format = "%B %d %Y, %T") # this was working earlier, but when I cleaned environment and re-ran data, it stopped working
wide_tbl[,5:9] <- replace(wide_tbl[,5:9], wide_tbl[,5:9]==0, NA)
wide_tbl <- drop_na(wide_tbl, q2)
long_tbl <- pivot_longer(wide_tbl, cols = 5:9, names_to = "question", values_to = "response", values_drop_na=FALSE)