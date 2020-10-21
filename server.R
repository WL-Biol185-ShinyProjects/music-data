library(tidyverse)
library(nycflights13)

#%in% makes multiple choices

function(input, output) {
  output$distancePlot <- renderPlot({
    flights %>%
      filter(carrier %in% input$airline) %>%
      ggplot(aes(distance, air_time)) +
      geom_point()
  })
  output$flightInfo <- renderDataTable({
    clickEvent <- input$distancePlotClick
    flights %>%
      filter(carrier %in% input$airline) %>%
      nearPoints(clickEvent)
  })
}

function(input, output) {
  output
}