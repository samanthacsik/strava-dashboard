mapFilters <- function(input) {

  reactive({
    acts |>
      filter(total_miles >= input$distance_sliderInput[1] & total_miles <= input$distance_sliderInput[2]) |>
      filter(elevation_gain_ft >= input$elevation_sliderInput[1] & elevation_gain_ft <= input$elevation_sliderInput[2])
  }) # END filtered_map

}
