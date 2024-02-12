# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- separate_wider_delim(import_tbl, qs, delim = " - ", names = c("q1", "q2", "q3", "q4", "q5"))
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], FUN = as.integer)
wide_tbl$datadate <- lubridate::as_datetime(wide_tbl$datadate, format = "%B %d %Y, %T")
wide_tbl[,5:9] <- replace(wide_tbl[,5:9], wide_tbl[,5:9]==0, NA)
wide_tbl <- drop_na(wide_tbl, q2) # can only use q2 without quotes inside tidyverse
long_tbl <- pivot_longer(wide_tbl, cols = 5:9, names_to = "question", values_to = "response", values_drop_na=FALSE)



# other ways line 8
wide_tbl2 <- separate(import_tbl, qs, into=("q1", "q2", "q3", "q4", "q5"))
wide_tbl2 <- separate(import_tbl, qs, into=paste0("q",1:5))
# other ways line 9
wide_tbl[,paste0("q",1:5)] <- sapply(wide_tbl[,paste0("q", 1:5)], as.integer)
# other ways line 10
wide_tbl$datadate <- mdy_hms(wide_tbl$datadate)
wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = "%B %d %Y, %T")
# other ways line 11
wide_tbl[paste0("q",1:5)] <- replace(wide_tbl[paste0("q",1:5)], wide_tbl[,5:9]==0, NA)
wide_tbl[,5:9][wide_tbl[,5:9]==0] <- NA
# other ways line 12
wide_tbl <- subset(wide_tbl, !is.na(wide_tbl$q2))
wide_tbl <- drop_na(wide_tbl, "q2")
# other ways line 13
long_tbl <- pivot_longer(wide_tbl, cols = starts_with("q"))
long_tbl <- pivot_longer(wide_tbl, cols = q1:q5) # can only do column titles as a range when using tidyverse