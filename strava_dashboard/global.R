# LOAD LIBRARIES ----
library(httr)
library(dplyr)
library(lubridate)
library(aws.s3)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(markdown)
library(fontawesome)
library(leaflet)
library(leaflet.extras)
library(ggplot2)
library(plotly)
library(DT)
# library(htmlwidgets)
# library(htmltools)
# library(fresh)

# IMPORT DATA ----
#acts <- readRDS("data/strava_acts_2024-09-05.rds")
acts <- s3readRDS(object = "wrangled_activities.rds",
                  bucket = "sams-strava-dashboard-data")

# GGPLOT THEME ----
stravaTheme <- theme_light() +
  theme(text = element_text(family = "Avenir"), # chosen from Font Book app on my Mac
        axis.text = element_text(color = "black", size = 12),
        axis.title = element_text(size = 14, face = "bold"),
        legend.title = element_text(size = 14, face = "bold"),
        legend.text = element_text(size = 13),
        panel.border = element_rect(colour = "black", fill = NA, linewidth = 0.7),
        plot.caption = element_text(size = 10, hjust = 0))
