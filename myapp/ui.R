# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(
  title = span(tags$a(img(src = "media/strava_logo.png"),
                      href = "https://www.strava.com/",
                      target = "_blank"), # _blank opens link in new tab
               "Sam's Strava Stats"
               ) # END span
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
               src = "media/sc_tallie_cropped.jpeg"),
      h2("Welcome to my app")
    ), # END "about" tabItem

    # ---------- dashboard tab ----------
    tabItem(
      tabName = "dashboard",
      h1("Explore the data"),

      # START total hikes info box ---
      # infoBoxOutput(inputId = "totalHikes") # END total hikes info box

      # # START total rides info box ---
      # infoBox(title = "Total Rides", value = NULL,
      #         icon = shiny::icon("bike"), color = "green", width = 4,
      #         href = NULL, fill = TRUE), # END total rides info box
      #
      # # START total walks info box ---
      # infoBox(title = "Total Walks", value = NULL,
      #         icon = shiny::icon("person-walking"), color = "orange", width = 4,
      #         href = NULL, fill = TRUE) # END total walks info box

      # sport type input ----
      pickerInput(inputId = "sport", label = "Select an activity:",
                  choices = c("Hike", "Bike" = "Ride", "Walk"),
                  options = pickerOptions(actionsBox = TRUE),
                  selected = c("Hike", "Bike" = "Ride", "Walk"),
                  multiple = T),

      # output ----
      plotOutput(outputId = "elev_dist_scatterplot")


    ), # END "dashboard" tab

    # ---------- tutorials tab ----------
    tabItem(
      tabName = "tutorials",
      h1("Want to learn how to work with your own Strava data?")
    ) # END "tutorials" tab

  ) # END tabItems()

) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(header, sidebar, body)
