shoeMileage_valueBox <- function(input) {

  # calculate total mileage (shoes) -----
  filtered_shoes <- reactive({
    acts |> filter(gear_name == input$gear_shoes_input) |>
      summarize(total = sum(total_miles))
  })

  # render valueBox ----
  renderInfoBox({
    valueBox("Total Mileage | Hiking boots should be replaced every ~500-1,000 miles", value = filtered_shoes(), color = "black", icon = icon("shoe-prints", lib = "font-awesome"))
  })


}
