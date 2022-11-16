# libraries ----

library(shiny)
library(shinydashboard)
library(tidyverse)
library(fontawesome)
library(shinyWidgets)

# data ----
acts <- readRDS("data/strava_acts_2022-11-11.rds")

# data viz theme ----
stravaTheme <- theme_light() +
  theme(text = element_text(family = "Avenir"), # chosen from Font Book app on my Mac
        axis.text = element_text(color = "black", size = 12),
        axis.title = element_text(size = 13),
        panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
        plot.caption = element_text(size = 10, hjust = 0))

# data viz colors ----
hike_color <- "#b35702"
bike_color <- "#744082"
walk_color <- "#366643"

