library(shiny)
library(shinydashboard)

ui<- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$style(".small-box.bg-yellow { background-color: #FFFF00 !important; color: #000000 !important; }"),
    tags$style(".small-box.bg-orange { background-color: #b35702 !important; color: #FFFFFF !important; }"),
    fluidRow(
      valueBoxOutput("name1"),
      valueBoxOutput("name2")
    )
  )
)

server<- function(input, output){
  output$name1 <- renderValueBox({
    valueBox("example", subtitle = "Subtitle text", color = "yellow")
  })
  output$name2 <- renderValueBox({
    valueBox("example", subtitle = "Subtitle text", color = "orange")
  })
}
shinyApp(ui = ui, server = server)
