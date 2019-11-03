library(tidyverse)
library(reshape2)

# From https://stackoverflow.com/a/42638713
options(readr.default_locale = readr::locale(tz = "America/New_York"))

# Analysis II
analysis <-
  read_csv(
    "data/raw/analysis_ii.csv",
    col_names = TRUE,
    col_types = cols(
      week.number = col_double(),
      mon = col_double(),
      thur = col_double(),
      fri = col_double()
    )
  ) %>%
  melt(id.vars = "week.number") %>%
  rename(day = variable, parts = value) %>%
  filter(week.number != 9) %>%  # Remove spring break
  add_column(class = "analysis.ii", .before = 1) %>%
  arrange(week.number, day) %>%
  slice(1:(n() - 2))  # Semester ended on a Monday

# Algebra
algebra <-
  read_csv(
    "data/raw/algebra.csv",
    col_names = TRUE,
    col_types = cols(
      week.number = col_double(),
      tue = col_double(),
      fri = col_double()
    )
  ) %>%
  melt(id.vars = "week.number") %>%
  rename(day = variable, parts = value) %>%
  filter(week.number != 4, week.number != 9) %>%  # Remove the flood and spring break
  add_column(class = "algebra", .before = 1) %>%
  arrange(week.number, day) %>%
  slice(1:(n() - 1))  # Semester ended on a Tuesday

bind_rows(analysis, algebra) %>%
  write_csv("data/tidy/parts.csv")