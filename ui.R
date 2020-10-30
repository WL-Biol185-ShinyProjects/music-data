library(shiny)
library(shinydashboard)
library(d3heatmap)

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
            "here is income data"
          ),
          box(
            title = "sth else",
            "this contains sth else"
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
            d3heatmapOutput("heatmapPlot"),
            p("genre",
              style = "writing-mode: vertical-rl; text-orientation: mixed;"
            )
          ),
          
          p("genre",
            style = "text-align: center;"
          )
        )
      ) 
    )
  )
)



