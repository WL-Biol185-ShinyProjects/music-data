library(shiny)
library(shinydashboard)
library(d3heatmap)
#fluidPage(
#  sidebarPanel(
#    selectInput(inputId = "airline",
#                label   = "Select airlines:",
#                choices = unique(flights$carrier))
#  ),
#  mainPanel(
#    plotOutput("distancePlot",
#               click = "distancePlotClick"),
#    dataTableOutput("flightInfo")
#  )
#)
decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")


dashboardPage(
  dashboardHeader(title = "Music Data"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",
               tabName = "Home", 
               icon = icon("home")),
      menuItem("income",
               tabName = "Income",
               icon = icon("widget")),
      menuItem("genre",
               tabName = "genre")
      
    )
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
              #h2("Introduction to music data"),
              fluidRow(
                h2("Intro to music"),
                box(title = "Introduction to music data", "what")
                      )
              ),
      tabItem(tabName = "income",
              h2("Income data")
              ),
      tabItem(tabName = "genre",
              he = "Genre data",
              fluidPage(
                sidebarPanel(
                  selectInput(inputId = "decade",
                              label = "Select decade:",
                              choices = decadeList)
                ),
                mainPanel(
                  d3heatmapOutput("heatmapPlot")
                )
              ) 
              )
    )
  )
)

