# ui ----

# header ----
header <- dashboardHeader(title = "Strava Dashboard")

# sidebar ----
sidebar <- dashboardSidebar("Menu")

# body ----
body <- dashboardBody("Test")

# combine header, sidebar, body into dashboardPage ----
ui <- dashboardPage(header, sidebar, body)
