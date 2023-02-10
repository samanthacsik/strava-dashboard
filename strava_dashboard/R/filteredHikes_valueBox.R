filteredHikes_valueBox <- function(input) {

  # filter for distance and elevation ranges based on sliderInputs ----
  filtered_map <- mapFilters(input)

  # get num hikes based on filtered data ----
  total_filtered_hikes <- reactive({
    filtered_map() |>
      filter(sport_type == "Hike") |>
      nrow()
  })

  # render valueBox ----
  renderValueBox({
    valueBox("Total Number of Recorded Hikes", value = total_filtered_hikes(), color = "orange", icon = icon("person-hiking", lib = "font-awesome"))
  })


}
