library(tidyverse)
library(reshape2)

# From https://stackoverflow.com/a/42638713
options(readr.default_locale=readr::locale(tz="America/New_York"))

process_csv <- function(name) {
  df <- read_csv(sprintf("data/raw/%s.csv", name), col_names = TRUE)
  df <- melt(df, id.vars = "week.number")
  df <- rename(df, day = variable, count = value)
  df <- arrange(df, week.number, day)
  write_csv(df, sprintf("data/tidy/%s.csv", name))
}
  
for (name in c("analysis_ii", "algebra")) {
  process_csv(name)
}