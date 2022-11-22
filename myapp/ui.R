# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(
  title = span(img(src="media/strava_logo.png", width = 38,
                   href = "https://www.strava.com/",
                   target = "_blank"),
               span("Sam's Strava Stats", style = "font-size: 18px;"))
  ) # END dashboardHeader

# ------------------------------------------ sidebar ------------------------------------------
sidebar <- dashboardSidebar(

  # START sidebarMenu
  sidebarMenu(

    menuItem("About the app", tabName = "about", icon = icon("star")),
    menuItem("Strava Dashboard", tabName = "dashboard", icon = icon("dashboard")),
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
               src = "media/camuesa_cropped.jpeg")
    ), # END "about" tabItem

    # ---------- dashboard tab ----------
    tabItem(
      tabName = "dashboard",
      #h1("Explore the data"),

      # style valueBox colors (tried moving this to styles.css but haven't got it working yet)
      tags$style(".small-box.bg-orange { background-color: #b35702 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-purple { background-color: #744082 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-green { background-color: #366643 !important; color: #FFFFFF !important; }"),

      # valueBoxes in first row
      fluidRow(
        valueBoxOutput(outputId = "totalHikes"),
        valueBoxOutput(outputId = "totalRides"),
        valueBoxOutput(outputId = "totalWalks")
      ), # END fluidRow

      # BOX (1) elev ~ dist plot
      fluidRow(
        box(width = 12,
            title = tags$strong("Explore distance and elevation stats"),
            # solidHeader = TRUE,
            # status = "navy",

          # sport type input ----
          pickerInput(inputId = "sport", label = "Select an activity:",
                      choices = c("Hike", "Bike" = "Ride", "Walk"),
                      options = pickerOptions(actionsBox = TRUE),
                      selected = c("Hike", "Bike" = "Ride", "Walk"),
                      multiple = T),

          # date range input ----
          # sliderInput(inputId = "date", label = "Select a date range:",
          #             min = min(acts$start_date_local),
          #             max = max(acts$start_date_local),
          #             value = c(min(acts$start_date_local, max(acts$start_date_local)))),
          dateRangeInput(inputId = "date", label = "Select a date range:",
                         min = min(acts$start_date_local), max = max(acts$start_date_local),
                         start = min(acts$start_date_local), end = max(acts$start_date_local)),

          # elev ~ dist scatterplot output ----
          plotOutput(outputId = "elev_dist_scatterplot") |> withSpinner(color = "#cb9e72", type = 1)
        ) # END box
      ), # END fluidRow

      # BOX (1) distance histogram & (2) elevation histogram
      fluidRow(
        box(width = 12,
            title = "Title here",
            solidHeader = TRUE,
            # status = "navy",

            # sport type input ----
            pickerInput(inputId = "sport", label = "Select an activity:",
                        choices = c("Hike", "Bike" = "Ride", "Walk"),
                        options = pickerOptions(actionsBox = TRUE),
                        selected = c("Hike", "Bike" = "Ride", "Walk"),
                        multiple = T),

            # distance histogram output ----
            plotOutput(outputId = "dist_histogram"),

            # elevation histogram output ----
            plotOutput(outputId = "elev_histogram")

        ) # END box
      ) # END fluidRow
    ), # END "dashboard" tab

    # ---------- tutorials tab ----------
    tabItem(
      tabName = "tutorials",
      # h1("Want to learn how to work with your own Strava data?")
    ) # END "tutorials" tab

  ), # END tabItems

) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(header, sidebar, body)
