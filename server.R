library(d3heatmap)
library(dplyr)
library(tidyverse)
library(ggplot2)

decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")
tables <- readRDS("DecadeTables.RDS")
names(tables) <- decadeList

color_tb <- data.frame(seq(-1,1,0.01), 1)
color_tb
colnames(color_tb) <- c("l", "r")

units_g <- readRDS("units.RDS")
units_g <- na.omit(units_g)
value_g <- readRDS("value.RDS")
value_g[["not_inf"]] <- na.omit(value_g[["not_inf"]])
value_g[["yes_inf"]] <- na.omit(value_g[["yes_inf"]])

function(input, output) {
  output$heatmapPlot <- renderD3heatmap({
    genre <- colnames(tables[[input$decade]])
    d3heatmap(cor(tables[[input$decade]]),
              labRow = genre,
              colors = "Spectral")
  })
  
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
      ylab("Value (In $)") +
      labs(color = 'Format')
  })
  
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

