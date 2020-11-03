library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

units_df <- read_excel("2019 RIAA Revenue data.xlsx", 
                                      sheet = "Units",
                       col_names = FALSE)
units_df <- units_df[c(1,3:18,20),]

View(units_df)

units_t <- t(units_df)
colnames(units_t) <- units_t[1,]
row.names(units_t) <- units_t[,1]

units_t <- data.frame(units_t[2:48, 2:18])
units_t$year <- row.names(units_t)
View(units_t)

units_g <- gather(units_t, key = "unit_type", value = "units", CD:Paid.Subscriptions)
View(units_g)
units_g$year <- as.integer(units_g$year)

saveRDS(units_g, "units.RDS")

#in ui
selectInput("Unit Type", choices = unique(units_g$unit_type), multiple = TRUE)

#in server
output$Plot <- renderPlot({
  table %>%
    filter(unit_type %in% input$Units) %>%
    ggplot(units_g, aes(x = year, y = units)) + geom_bar()
})
