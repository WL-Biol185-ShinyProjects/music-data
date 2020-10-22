library(shiny)
library(shinydashboard)
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
  dashboardHeader(title = ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",
               tabName = "Home"),
      menuItem("income",
               tabName = "Income"),
      menuItem("genre",
               tabName = "genre")
      
    )
    
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home"),
      tabItem(tabName = "income"),
      tabItem(tabName = "genre",
              fluidPage(
                sidebarPanel(
                  selectInput(inputId = "decade",
                              label = "Select decade:",
                              choices = decadeList)
                ),
                mainPanel(
                  plotOutput("heatmapPlot")
                )
              ) 
              )
    )
  )
)

