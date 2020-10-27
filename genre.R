library(heatmaply)
library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

# make function called sheet_sort with input: decades you want to see (eg. "1950s"), 
# and output: heatmap of correlation between genres in that decade

sheet_sort <- function(input) {

  df        <- read_excel("pivot_byDecade.xlsx",
                          sheet = input)
  df        <- data.frame(df[,3:17])
}

decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")


#make list of dataframes
#vector of years -- load 

tables <- lapply(decadeList, sheet_sort(decade) {
                                sheet_sort(decade)

                             }
                )

tables
names(tables) <- decadeList

saveRDS(tables, "DecadeTables.RDS")


