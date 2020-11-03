library(shiny)
library(shinydashboard)
library(d3heatmap)

decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")

units_g <- readRDS("units.RDS")

dashboardPage(
  dashboardHeader(title = "Music Data"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Home",
               tabName = "home", 
               icon = icon("home")),
      menuItem("income",
               tabName = "income",
               icon = icon("widget")),
      menuItem("genre",
               tabName = "genre")
      
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "home",
        fluidRow(
          box(
            title = "Introduction to music data", 
            "what"
          )
        )
      ),
      tabItem(tabName = "income",
        fluidRow(
          box(
            title = "Introduction to music data",
            background = "light-blue",
            "here is income data"
          ),
          box(
            title = "sth else",
            background = "yellow",
            "this contains sth else"
          )
        ),
        fluidRow(
          sidebarPanel(
            selectInput(
              inputId = "unit_type",
              label = "Select unit:",
              choices = unique(units_g$unit_type),
              multiple = TRUE)
          ),
          mainPanel(
            plotOutput("incomePlot"),
          )
        )
      ),
      tabItem(tabName = "genre",
        fluidRow(
          box(
            title = "genre data",
            background = "light-blue",
            "here is genre data"
          ),
          box(
            title = "data source",
            background = "yellow",
            "here is how to read the data"
          )
        ),
        fluidRow(
          sidebarPanel(
            selectInput(
              inputId = "decade",
              label = "Select decade:",
              choices = decadeList
            )
          ),
          mainPanel(
            d3heatmapOutput("heatmapPlot")
          )
        )
      ) 
    )
  )
)



