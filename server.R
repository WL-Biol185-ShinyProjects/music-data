library(d3heatmap)
library(dplyr)
library(tidyverse)
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
#source("genre.R")
tables <- readRDS("DecadeTables.RDS")
names(tables) <- decadeList


function(input, output) {
  output$heatmapPlot <- renderD3heatmap({
    genre <- colnames(tables[[input$decade]])
    d3heatmap(cor(tables[[input$decade]]),
              labRow = genre,
              colors = "Spectral")
    
    
  }),
  output$
}

#heatmaply(data.frame(tables["1950s"]))
