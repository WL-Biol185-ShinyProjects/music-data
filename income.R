library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

#download and clean units sheet
units_df <- read_excel("2019 RIAA Revenue data.xlsx", 
                                      sheet = "Units",
                       col_names = FALSE)
units_df <- units_df[c(1,3:18,20),]
units_t <- t(units_df)
colnames(units_t) <- units_t[1,]
row.names(units_t) <- units_t[,1]
units_t <- data.frame(units_t[2:48, 2:18])
units_t$year <- row.names(units_t)
units_g <- gather(units_t, key = "unit_type", value = "units", CD:Paid.Subscriptions)
View(units_g)
units_g[24:30,3] <- abs(units_g[24:30,3])
units_g$year <- as.integer(units_g$year)

saveRDS(units_g, "units.RDS")

#try to make function
value_sheets <- function(input){
  df <- read_excel("2019 RIAA Revenue data.xlsx",
                   sheet = input,
                   col_names = FALSE)
  df <- df[c(1,3:25),]
  df_t <- t(df)
  colnames(df_t) <- df_t[1,]
  row.names(df_t) <- df_t[,1]
  df_t <- data.frame(df_t[2:48, 2:24])
  df_t$year <- row.names(df_t)
  df_g <- gather(df_t, key = "value_type", value = "values", CD:Synchronization)
  df_g$year <- as.integer(df_g$year)
  df$values[df$values == "-"] <- NA
  df$values <- abs(df$values)
  return(df_g)
}

inf_list <- c("not_inf", "yes_inf")

inf_table <- list("not_inf" = value_sheets("Value"),
                  "yes_inf" = value_sheets("Value adjusted for inflation")
)



saveRDS(inf_table, "value.RDS")

