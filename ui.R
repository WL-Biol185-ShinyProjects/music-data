

fluidPage(
  sidebarPanel(
    selectInput(inputId = "airline",
                label = "Select airlines:",
                choices = unique(flights$carrier))
  ),
  mainPanel(
    plotOutput("distancePlot",
               click = "distancePlotClick"),
    dataTableOutput("flightInfo")
  )
)

fluidPage{
  sidebarPanel()
}