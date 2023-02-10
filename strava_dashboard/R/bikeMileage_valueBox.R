bikeMileage_valueBox <- function(input) {

  # calculate total mileage (bike) ----
  filtered_bikes <- reactive({
    acts |> filter(gear_name == input$gear_bike_input) |>
      summarize(total = sum(total_miles))
  })

  # render valueBoxe ----
  renderInfoBox({
    valueBox("Total Mileage ", value = filtered_bikes(), color = "black", icon = icon("bicycle", lib = "font-awesome"))
  })

}
