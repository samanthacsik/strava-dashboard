# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse)
library(plotly)
library(DT)
library(leaflet)
library(leaflet.extras)
library(htmlwidgets)
library(htmltools)
library(fontawesome)
library(markdown)
library(fresh)
library(aws.s3)

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

# STYLING ----
# hike_color <- "#b35702" # orange
# bike_color <- "#744082" # purple
# walk_color <- "#366643" # green

# SPINNER STYLING (NOT WORKING) ----
# options(spinner.type = 6, spinner.size = 2 , spinner.color = "#cb9e72")

# SLIDESHOW IMAGES ----
# imgs <- list.files("strava_dashboard/www/slideshow_photos", pattern = ".jpeg", full.names = TRUE)

