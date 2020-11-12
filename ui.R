library(shiny)
library(shinydashboard)
library(d3heatmap)

decadeList <- c("1950s", "1960s", "1970s", "1980s", "1990s", "2000s")

units_g <- readRDS("units.RDS")
value_g <- readRDS("value.RDS")


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
            sliderInput(inputId = "year_slider",
                        label = "Select years to display:",
                        min = 1973,
                        max = 2019,
                        value = c(1973, 2019)
            )
          ),
          mainPanel(
            tabsetPanel(type = "tabs",
                        
                            
                        tabPanel("Units", 
                                 selectInput(
                                   inputId = "unit_type",
                                   label = "Select Unit Format:",
                                   choices = unique(units_g$unit_type),
                                   multiple = TRUE),
                                 plotOutput("unitPlot",
                                             brush = "plot_brush"),
                                 verbatimTextOutput("info_brush")
                                 ),
                        tabPanel("Value", 
                                 selectInput(
                                   inputId = "value_type",
                                   label = "Select Value Format:",
                                   choices = unique(value_g[["yes_inf"]]$value_type),
                                   multiple = TRUE
                                 ),
                                 radioButtons("inf", "choose adjusted for inflation or not:",
                                              c("Value not adjusted for inflation" = "not_inf",
                                                "Value adjusted for inflation" = "yes_inf")
                                 ),
                                 plotOutput("valuePlot",
                                            brush = "plot_brush"),
                                 verbatimTextOutput("value_brush")
                        )
            #plotOutput("incomePlot",
            #click = "plot_click"),
            #verbatimTextOutput("info_click")
            )
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
            plotOutput("colorLegend")
          )
        )
      ) 
    )
  )
)



