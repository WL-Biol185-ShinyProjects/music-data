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

units_g <- readRDS("units.RDS")
View(units_g)
units_g <- na.omit(units_g)

function(input, output) {
  output$heatmapPlot <- renderD3heatmap({
    genre <- colnames(tables[[input$decade]])
    d3heatmap(cor(tables[[input$decade]]),
              labRow = genre,
              colors = "Spectral")
  })
  
  output$incomePlot <- renderPlot({
     units_g %>%
      filter(unit_type %in% input$unit_type) %>%
      ggplot(aes(x = as.numeric(year), y = as.numeric(units), color = unit_type, group = unit_type)) + 
      geom_line() + 
      geom_point(aes(color = unit_type)) +
      xlim(1973,2019) +
      ylim(0,1402.739) +
      xlab("year") +
      ylab("units")
  })
}



#heatmaply(data.frame(tables["1950s"]))
