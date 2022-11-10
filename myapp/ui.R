# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(title = "Sam's Strava Stats")

# ------------------------------------------ sidebar ------------------------------------------
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About the app", tabname = "about", icon = icon("star")),
    menuItem("Strava Dashboard", tabname = "dashboard", icon = icon("dashboard")),
    menuItem("Tutorials", tabname = "tutorials", icon = icon("laptop-code"))
  ) # END sidebarMenu
) # END dashboardSidebar

# ------------------------------------------ body ------------------------------------------
body <- dashboardBody(

  # load stylesheet ----
  tags$head(
    tags$link(rel = "stylesheet",
              type = "text/css",
              href = "styles.css")
  ), # END tags$head

  # welcome tab ----
  tabItem(tabName = "about",
          tags$img(class = "banner",
                   src = "media/jenna_hike.jpeg"),
  ) # END "about" tabItem
) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(header, sidebar, body)
