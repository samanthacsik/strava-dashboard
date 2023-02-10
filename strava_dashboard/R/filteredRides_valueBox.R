filteredRides_valueBox <- function(input) {

  # filter for distance and elevation ranges based on sliderInputs ----
  filtered_map <- mapFilters(input)

  # get num rides based on filtered data ----
  total_filtered_rides <- reactive({
    filtered_map() |>
      filter(sport_type == "Ride") |>
      nrow()
  })

  # render valuebox ----
  renderValueBox({
    valueBox("Total Number of Recorded Bike Rides", value = total_filtered_rides(), color = "purple", icon = icon("person-biking", lib = "font-awesome"))
  })

}
