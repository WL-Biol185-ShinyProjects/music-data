library(heatmaply)
library(dplyr)
library(tidyverse)
library(readxl)
library(ggplot2)

#%in% makes multiple choices

#function(input, output) {
#  output$distancePlot <- renderPlot({
#    flights %>%
#      filter(carrier %in% input$airline) %>%
#      ggplot(aes(distance, air_time)) +
#      geom_point()
#  })
#  output$flightInfo <- renderDataTable({
#    clickEvent <- input$distancePlotClick
#    flights %>%
#      filter(carrier %in% input$airline) %>%
#      nearPoints(clickEvent)
#  })
#}

#mycode
decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")
sheet_sort <- function(decade) {
  df        <- read_excel("pivot_byDecade.xlsx",
                          sheet = decade)
  df        <- data.frame(df)
  df        <- df[,3:17]
  df_plot   <- heatmaply_cor(cor(df),
                             labRow = df$Genre)
  #list_plot <- append(list_plot, df_plot)
  return(df_plot)
}
#sheet_sort("1950s")

function(input, output) {
  output$heatmapPlot <- renderPlot({
    
    sheet_sort(input$decade)
    
  })
}
