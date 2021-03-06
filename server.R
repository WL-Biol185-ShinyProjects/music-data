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

color_tb <- data.frame(seq(-1,1,0.01), 1)
color_tb
colnames(color_tb) <- c("l", "r")

units_g <- readRDS("units.RDS")
units_g <- na.omit(units_g)
value_g <- readRDS("value.RDS")
value_g <- na.omit(value_g)

function(input, output) {
  output$heatmapPlot <- renderD3heatmap({
    genre <- colnames(tables[[input$decade]])
    d3heatmap(cor(tables[[input$decade]]),
              labRow = genre,
              colors = "Spectral")
  })
    
  #output$colorLegend <- renderPlot({
    #ggplot(color_tb, aes(x=r, y=l)) + 
    #geom_tile(aes(fill = l), show.legend = FALSE) + 
    #scale_fill_gradientn(colors = Spectral(50)) +
    #theme(panel.background = element_blank(), 
          #axis.ticks.x     = element_blank(),
          #axis.title.x     = element_blank(),
          #axis.text.x      = element_blank(),
          #axis.ticks.y     = element_blank(),
          #axis.title.y     = element_blank(),
          #axis.text.y      = element_blank())
  #})
  
  output$unitPlot <- renderPlot({
    units_g %>%
      filter(unit_type %in% input$unit_type) %>%
      ggplot(aes(x = as.numeric(year), y = as.numeric(units), color = unit_type, group = unit_type)) + 
      geom_line() + 
      geom_point(aes(color = unit_type)) +
      xlim(input$year_slider[1], input$year_slider[2]) +
      #ylim(0,1402.739) +
      xlab("Year") +
      ylab("Units (In Millions)") +
      labs(color = 'Format')
  })
  
  output$valuePlot <- renderPlot({
    value_g[[input$inf]] %>%
      filter(value_type %in% input$value_type) %>%
      ggplot(aes(x = as.numeric(year), y = as.numeric(values), color = value_type, group = value_type)) + 
      geom_line() + 
      geom_point(aes(color = value_type)) +
      xlim(input$year_slider[1], input$year_slider[2]) +
      xlab("Year") +
      ylab("Value (In Millions of $)") +
      labs(color = 'Format')
  })
  
  #output$info_click <- renderText({
    #xclick          <- input$plot_click$x
    #yclick          <- input$plot_click$y
    #nearPoints(units_g, input$plot_click,
              # xvar = "year", yvar = "units")
  #})
  
  output$info_brush <- renderPrint({
    brushedPoints(units_g %>%
                    filter(unit_type %in% input$unit_type), 
                  input$plot_brush,
                  xvar = "year", yvar = "units")
  })
  output$value_brush <- renderPrint({
    brushedPoints(value_g[[input$inf]] %>%
                    filter(value_type %in% input$value_type), 
                  input$plot_brush,
                  xvar = "year", yvar = "values")
  })
}

