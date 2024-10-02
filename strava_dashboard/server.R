
server <- function(input, output) {

  #.....................gear garage valueBoxes.....................
  output$gear_shoes_mileage <-  shoeMileage_valueBox(input)
  output$gear_bike_mileage <- bikeMileage_valueBox(input)

  #....................valueBoxes & leaflet map....................
  output$total_filtered_hikes <- filteredHikes_valueBox(input)
  output$total_filtered_rides <- filteredRides_valueBox(input)
  output$total_filtered_walks <- filteredWalks_valueBox(input)
  output$strava_map <- leaflet_map(input)

  #..................elevation & distance data viz.................
  output$dist_histogram <- elevDist_histogram(input, xvar = total_miles, xlab = "Total Distance (miles)")
  output$elev_histogram <- elevDist_histogram(input, xvar = elevation_gain_ft, xlab = "Total Elevation Gain (ft)")
  output$elev_dist_scatterplot <- elevByDist_scatterplot(input)

  #............elevation & distance summary stats table............
  output$dist_elev_stats_table <- elevDist_sumStats_table(input)

  #......................DT table (raw data).......................
  output$strava_data_trimmed <- stravaData_DTdatatable(input)

} # END SERVER


