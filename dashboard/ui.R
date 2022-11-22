# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(
  title = span(img(src="media/strava_logo.png", width = 38,
                   href = "https://www.strava.com/",
                   target = "_blank"), # target = "_blank" opens link in new tab
               span("Sam's Strava Stats", style = "font-size: 18px;"))
  ) # END dashboardHeader

# ------------------------------------------ sidebar ------------------------------------------
sidebar <- dashboardSidebar(

  # START sidebarMenu
  sidebarMenu(

    menuItem("About the app", tabName = "about", icon = icon("star")),
    menuItem("Strava Dashboard", tabName = "dashboard", icon = icon("tachometer-alt")),
    menuItem("Data", tabName = "data", icon = icon("table")),
    menuItem("Tutorials", tabName = "tutorials", icon = icon("laptop-code"))

  ) # END sidebarMenu

) # END dashboardSidebar

# ------------------------------------------ body ------------------------------------------
body <- dashboardBody(

  # load stylesheet ----
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ), # END tags$head

  # tabItems() ----
  tabItems(

    # ---------- about tab ----------
    tabItem(
      tabName = "about",
      tags$img(class = "banner",
               src = "media/camuesa_cropped.jpeg"),
      includeMarkdown("text/home_page_footer.md")
    ), # END "about" tabItem

    # ---------- dashboard tab ----------
    tabItem(
      tabName = "dashboard",

      # style valueBox colors (tried moving this to styles.css but haven't got it working yet)
      tags$style(".small-box.bg-orange { background-color: #b35702 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-purple { background-color: #744082 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-green { background-color: #366643 !important; color: #FFFFFF !important; }"),

      # valueBoxes ----
      fluidRow(
        valueBoxOutput(outputId = "totalHikes"),
        valueBoxOutput(outputId = "totalRides"),
        valueBoxOutput(outputId = "totalWalks")
      ), # END fluidRow

      # leaflet map ----
      fluidRow(
        leafletOutput(outputId = "strava_map", height = 500)
      ), # END fluidRow

      # add some space between map and plots ----
      headerPanel(""),

      # distance & elevation plots ----
      fluidRow(
        tabBox(width = 12,
               title = tags$strong("Explore distance and elevation stats"),
               side = "right", selected = "Distance & Elevation Summary Stats",

               # elev ~ dist scatterplot ----
               tabPanel("Elevation Gained ~ Distance Traveled",
                        sport_type_pickerInput(inputId = "sport_scatterplot"), # sport type input )
                        date_range_airDatepickerInput(inputId = "date_scatterplot"), # date range input
                        plotly::plotlyOutput(outputId = "elev_dist_scatterplot") |> withSpinner(color = "#cb9e72", type = 1) # elev ~ dist scatterplot output
               ), # END tabPanel (scatterplot)

               # dist & elev histograms ----
               tabPanel("Distance & Elevation Summary Stats",
                        sport_type_pickerInput(inputId = "sport_histogram"), # sport type input
                        date_range_airDatepickerInput(inputId = "date_histogram"), # date range input
                        splitLayout(cellWidths = c("50%", "50%"), # histogram outputs
                                    plotOutput(outputId = "dist_histogram") |> withSpinner(color = "#cb9e72", type = 1),
                                    plotOutput(outputId = "elev_histogram") |> withSpinner(color = "#cb9e72", type = 1)),
                        tableOutput(outputId = "dist_elev_stats_table")
               ), # END tabPanel (histograms)

              ) # END tabBox
      ), # END fluidRow
    ), # END "dashboard" tab

    # ---------- data tab ----------
    tabItem(
      tabName = "data",
      DT::dataTableOutput(outputId = "strava_data_trimmed")
    ), # END "data" tab

    # ---------- tutorials tab ----------
    tabItem(
      tabName = "tutorials",
      # h1("Want to learn how to work with your own Strava data?")
    ) # END "tutorials" tab

  ), # END tabItems

) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(header, sidebar, body)
