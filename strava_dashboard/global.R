# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinycssloaders)
library(tidyverse)
library(plotly)
library(DT)
library(leaflet)
library(googleway)
library(htmlwidgets)
library(htmltools)
library(fontawesome)
library(markdown)
library(fresh)
# library(bsplus)
library(slickR)
library(reactlog)

# IMPORT DATA ----
acts <- readRDS("data/strava_acts_2023-01-09.rds")

# IMPORT FUNCTIONS, PLOTS, THEMES ----
source("R/sport_type_pickerInput.R")
source("R/date_range_inputs.R")
# source("R/fresh_theme.R")

# create icons for leaflet ----
hiker_icon_custom <- makeIcon(
  iconUrl = "www/media/hiker.png",
  iconWidth = 20, iconHeight = 20
)

bike_icon_custom <- makeIcon(
  iconUrl = "www/media/bike.png",
  iconWidth = 22, iconHeight = 25
)

walk_icon_custom <- makeIcon(
  iconUrl = "www/media/walker.png",
  iconWidth = 13, iconHeight = 18
)

# DATA WRANGLING FOR DATA TAB ----
acts_trimmed <- acts |>
  select(`Activity Title` = name, `Sport` = sport_type_alt, `Date` = start_date_local,
         `Distance Traveled (miles)` = total_miles, `Elevation Gain (ft)` = elevation_gain_ft,
         `Highest Elevation (ft)` = elev_high_ft, `Lowest Elevation (ft)` = elev_low_ft,
         `Average Speed (miles/hr)` = avg_speed_mi_hr, `Max Speed (miles/hr)` = max_speed_mi_hr,
         `Moving Time` = moving_time_hrs_mins, `Elapsed Time` = elapsed_time_hrs_mins,
         `Achievement Count` = achievement_count, `PR Count` = pr_count,) |>
  mutate(`Moving Time` = as.character(`Moving Time`),
         `Elapsed Time` = as.character(`Elapsed Time`))

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
imgs <- list.files("strava_dashboard/www/slideshow_photos", pattern = ".jpeg", full.names = TRUE)

