
library(shiny)
#library(slickR)
library(fs)

# imgs <- list.files(path = "www", pattern = ".jpeg", full.names = TRUE)
imgs <- dir_ls(path = "www", glob = "*.jpeg")

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      "sidebarPanel here",
      actionButton("previous", "Previous"),
      actionButton("next", "Next")
    ),

    mainPanel(
      "mainPanel here",
      imageOutput(outputId = "image", width = "50%", height = "100px")
      # slickROutput(outputId = "slickr", width="500px")
    )
  )
)

server <- function(input, output) {

  # output$slickr <- renderSlickR({
  #   slickR(obj = imgs)
  # })

  index <- reactiveVal(1)

  observeEvent(input[["previous"]], {
    index(max(index()-1, 1))
  })
  observeEvent(input[["next"]], {
    index(min(index()+1, length(imgs)))
  })

  output$image <- renderImage({
    x <- imgs[index()]
    list(src = x, alt = "alternate text")
  }, deleteFile = FALSE)

}

# Run the application
shinyApp(ui = ui, server = server)













# library(slickR)
# library(svglite)
# library(gdtools)
# library(shiny)
#
# ui <- fluidPage(
#   sidebarLayout(
#     sidebarPanel(
#
#       sliderInput(inputId = "plot_num",
#                   label = "Number of Plots:",
#                   min = 1, max = 20, value = 5),
#
#       sliderInput(inputId = "n_obs",
#                   label = "Number of observations:",
#                   min = 10, max = 500, value = 100),
#
#       shiny::radioButtons('slick_type',
#                           label = 'Carousel Type',
#                           choices = c('single','stack','synch'),
#                           selected = 'single',
#                           inline = TRUE),
#
#       shiny::verbatimTextOutput('current')
#     ),
#     mainPanel(
#
#       slickROutput("slick_output",width='100%',height='200px')
#
#     )
#   )
# )
#
# server <- function(input, output) {
#
#   # Create content for the carousel
#
#   plots <- eventReactive(c(input$n_obs,input$plot_num),{
#
#     replicate(input$plot_num,{
#
#       xmlSVG({hist(rnorm(input$n_obs),
#                    col = 'darkgray',
#                    border = 'white')},
#              standalone=TRUE)
#
#     },simplify = FALSE)
#   })
#
#   # renderSlickR (We create the slickR objects here)
#
#   output$slick_output <- renderSlickR({
#
#     x <- slickR(plots(),
#                 slideId = 'slick1',
#                 height = 600,
#                 width = '50%') +
#       settings(slidesToShow=3,centerMode=TRUE)
#
#     y <- slickR(plots(),
#                 slideId = 'slick2',
#                 height = 600,
#                 width = '50%') +
#       settings(slidesToShow=3,centerMode=TRUE)
#
#     switch(input$slick_type,
#            'single' = x,
#            'stack'  = x %stack% y,
#            'synch'  = x %synch% y
#     )
#
#   })
#
#   # Observe the active slick
#
#   # The htmlwidget is observed by shiny and information can be retrieved.
#
#   # Using the output name you set for the `renderSlick` object in this example
#   # it is `output$slick_output`
#
#   # Using this you can interact server-side "on click" of the active carousel
#   # by accessing elements in `input$slick_output_current$`
#
#   # `.clicked`   : The index of the clicked element|
#   # `.relative_clicked`: The relative position of the clicked element|
#   # `.center`    : The index of the center element|
#   # `.total`     : The total number of elements in the carousel|
#   # `.active`    : The ID of the active carousel|
#
#   # We will store this information in a new reactive environment
#   active_slick <- shiny::reactiveValues()
#
#   shiny::observeEvent(input$slick_output_current,{
#     active_slick$clicked    <- input$slick_output_current$.clicked
#     active_slick$relative_clicked <- input$slick_output_current$.relative_clicked
#     active_slick$center     <- input$slick_output_current$.center
#     active_slick$total      <- input$slick_output_current$.total
#     active_slick$active     <- input$slick_output_current$.slide
#   })
#
#   # Show in the UI the values in active_slick
#
#   output$current <- renderText({
#     l <- unlist(shiny::reactiveValuesToList(active_slick))
#     paste(gsub('_',' ', names(l)), l, sep=' = ', collapse='\n')
#   })
#
# }
#
# shinyApp(ui = ui, server = server)









# https://stackoverflow.com/questions/67123687/how-to-prevent-plot-from-overspilling-out-of-box-in-shiny-box

# library(shinydashboard)
# library(shiny)
#
# my_height = "30em"
#
# ui <- dashboardPage(
#   dashboardHeader(title = "Box alignmnent test"),
#   dashboardSidebar(),
#   dashboardBody(
#     # Put boxes in a row
#     fluidRow(
#       box(
#         title = "Image Goes Here",
#         img(src='https://cdn.vox-cdn.com/thumbor/ULiGDiA4_u4SaK-xexvmJVYUNY0=/0x0:640x427/1400x1050/filters:focal(0x0:640x427):format(jpeg)/cdn.vox-cdn.com/assets/3218223/google.jpg',
#             align = "center", style = paste0("width: 100%; height: ", my_height, ";"))
#       ),
#       box(title = "Plot", plotOutput("speed_distbn", height = my_height))
#     )
#   )
# )
#
#
#
# server <- function(input, output) {
#   output$speed_distbn <- renderPlot(plot(1))
# }
# shinyApp(ui, server)

#-------------------------------------

# library(shiny)
# library(shinydashboard)
#
#
# ui <- dashboardPage(
#   dashboardHeader(),
#   dashboardSidebar(),
#   dashboardBody(
#     fluidPage(
#       box(width = 12,
#           title = "Some Title",
#           collapsible = TRUE,
#           solidHeader = TRUE,
#           status = "danger",
#           box(widht = 12,
#               title = "Some Sub Title",
#               collapsible = TRUE,
#               solidHeader = TRUE,
#               box(
#                 width = 12,
#                 title = "Details 1",
#                 collapsible = TRUE,
#                 solidHeader = TRUE,
#                 collapsed = TRUE,
#                 status = "info",
#                 tableOutput("Placeholder_Table_1")
#               ),
#               #actionButton(inputId = "Action_1",
#               #             label = "Does nothing"
#               #),
#               plotOutput("Placeholder_Plot_1")
#           ),
#           box(width = 12,
#               title = "Sub Title 2",
#               collapsible = TRUE,
#               solidHeader = TRUE,
#               plotOutput("Placeholder_Plot_2"),
#               box(
#                 width = 12,
#                 title = "Details 2",
#                 collapsible = TRUE,
#                 solidHeader = TRUE,
#                 collapsed = TRUE,
#                 status = "info",
#                 tableOutput("Placeholder_Table_2")
#               )
#
#           )
#       )
#     )
#   )
# )
#
# server <- function(input, output) {
#
#   output$Placeholder_Table_1 <- renderTable(
#     tibble('Variable 1' = "X",
#            'Variable 2' = "Y",
#            'Variable 3' = "Z"
#     )
#   )
#
#   output$Placeholder_Table_2 <- renderTable(
#     tibble('Variable 1' = "X",
#            'Variable 2' = "Y",
#            'Variable 3' = "Z"
#     )
#   )
#
#   output$Placeholder_Plot_1 <- renderPlot(
#     ggplot(data = mtcars) +
#       labs(title = "Placeholder Plot 1")
#   )
#
#   output$Placeholder_Plot_2 <- renderPlot(
#     ggplot(data = mtcars) +
#       labs(title = "Placeholder Plot 2")
#   )
#
# }
#
# shinyApp(ui, server)

# -------------------------------------------------------

# library(shiny)
# library(shinydashboard)
# # library(shinyjs)
#
# ui <- dashboardPage(
#   dashboardHeader(),
#   dashboardSidebar(),
#   dashboardBody(
#     # useShinyjs(),
#     actionButton("button", "Click me"),
#     div(id = "hello", "Hello!")
#   )
# )
#
# server <- function(input, output) {
#   observeEvent(input$button, {
#     toggle("hello")
#   })
# }
#
# shinyApp(ui, server)
