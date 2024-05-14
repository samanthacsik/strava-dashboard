library(tidyverse)

test_acts <- readRDS(here::here("strava_dashboard", "data", "strava_acts_2024-04-29.rds"))


hikes_only <- test_acts |>
  filter(sport_type == "Hike") |>
  filter(start_date_local >= min(start_date_local) & start_date_local <= max(start_date_local))
  summarize(
    #`Total # of Activities` = nrow(),
    `Min Distance (mi)` = min(total_miles),
    `Avg Distance (mi)` = mean(total_miles),
    `Max Distance (mi)` = max(total_miles),
    `Aggregate Distance (mi)` = sum(total_miles),
    `Min Elevation Gain (ft)` = min(elevation_gain_ft),
    `Avg Elevation Gain (ft)` = mean(elevation_gain_ft),
    `Max Elevation Gain (ft)` = max(elevation_gain_ft),
    `Aggregate Elevation Gain (ft)` = sum(elevation_gain_ft))


  hikes_only_scatter <- test_acts |>
    filter(sport_type %in% c("Hike")) |>
    filter(start_date_local >= min(start_date_local) & start_date_local <= max(start_date_local))
