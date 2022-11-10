# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(title = "Sam's Strava Stats")

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

  # START tabItems()
  tabItems(

    # START about tab ----
    tabItem(
      tabName = "about",
      tags$img(class = "banner",
               src = "media/sc_tallie_cropped.jpeg"),
      h2("Welcome to my app")
    ), # END "about" tabItem

    # START dashboard tab ----
    tabItem(
      tabName = "dashboard",
      h1("Explore the data")
    ), # END "dashboard" tab

    # START tutorials tab ----
    tabItem(
      tabName = "tutorials",
      h1("Want to learn how to work with your own Strava data?")
    ) # END "tutorials" tab

  ) # END tabItems()

) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(header, sidebar, body)
