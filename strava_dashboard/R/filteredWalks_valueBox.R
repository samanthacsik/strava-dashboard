filteredWalks_valueBox <- function(input) {

  # filter for distance and elevation ranges based on sliderInputs ----
  filtered_map <- mapFilters(input)

  # get num walks based on filtered data ----
  total_filtered_walks <- reactive({
    filtered_map() |>
      filter(sport_type == "Walk") |>
      nrow()
  })

  # render valueBox ----
  renderValueBox({
    valueBox("Total Number of Recorded Walks", value = total_filtered_walks(), color = "green", icon = icon("person-walking", lib = "font-awesome"))
  })

}

