# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(fontawesome)
library(shinyWidgets)

# IMPORT DATA ----
acts <- readRDS("data/strava_acts_2022-11-11.rds")

# GGPLOT THEME ----
stravaTheme <- theme_light() +
  theme(text = element_text(family = "Avenir"), # chosen from Font Book app on my Mac
        axis.text = element_text(color = "black", size = 12),
        axis.title = element_text(size = 13),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        plot.caption = element_text(size = 10, hjust = 0))

# STYLING ----
hike_color <- "#b35702"
bike_color <- "#744082"
walk_color <- "#366643"

# DATA FRAMES ----

