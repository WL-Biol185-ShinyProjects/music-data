library(heatmaply)
library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

# make function called sheet_sort with input: decades you want to see (eg. "1950s"), 
# and output: heatmap of correlation between genres in that decade
sheetList <- c()
decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")
shit <- function(input, output) {
  x <- read_excel("pivot_byDecade.xlsx",
                  sheet = inpu)
}
for(i in 1:6){
  y <- read_excel("pivot_byDecade.xlsx",
                  sheet = decadeList[i])
  append(sheetList, y)
}
sheetList[2]


sheet_sort <- function(input) {
  # read excel with specific sheet (input decade) and store into df
  df        <- read_excel("pivot_byDecade.xlsx",
                          sheet = input)
  # make df a data frame
  df        <- data.frame(df)
  # sort out columns with data
  df        <- df[,3:17]
  # make plot using heatmaply_cor function
  df_plot   <- heatmaply_cor(cor(df),
                             labRow = df$Genre)
  # not working yet - trying to add plot to a vector every time you go through it
  list_plot <- append(list_plot, df_plot)
  return(df_plot)
}

sheet_sort("1950s")

# for later - trying to go through every variable in this list to pass through function
input <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")