library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

units_df <- read_excel("2019 RIAA Revenue data.xlsx", 
                                      sheet = "Units")
units_df <- data.frame(units_df[c(2:17,19),])

View(units_df)

units_t <- data.frame(t(units_df))
units_t$year <- row.names(units_t)
View(units_t)

units_g <- gather(units_t, key = "unit_type", value = "units", CD:Paid.Subscriptions)




in ui
selectInput("someId", choices = unique(table$unit_types), multiple = TRUE)

in server
output$myPlot <- renderPlot({
  table %>%
    filter(unit_types %in% input$someId) %>%
    ggplot() + geom_bar
})