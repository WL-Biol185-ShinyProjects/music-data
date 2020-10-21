library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

units_df <- read_excel("2019 RIAA Revenue data.xlsx", 
                                      sheet = "Units")
units_df <- data.frame(units_df[c(2:17,19),])
colnames(units_df) <- c("inc_source", 1973:2019)
View(units_df)

units_t <- t(units_df)
colnames(units_t) <- units_t[1,]
units_t <- units_t[2:48,]
View(units_t)
units_t

units_melt <- units_t %>%
  gather(key, value)
View(units_melt)

ggplot(units_, aes(x=inc_source, y=1973, col=inc_source)) + geom_point()


