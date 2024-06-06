shoeMileage_valueBox <- function(input) {

  # calculate total mileage (shoes) -----
  filtered_shoes <- reactive({
    acts |> filter(gear_name == input$gear_shoes_input) |>
      summarize(total = sum(total_miles))
  })

  # render valueBox ----
  renderInfoBox({
    valueBox("Total Mileage", value = filtered_shoes(), color = "black", icon = icon("shoe-prints", lib = "font-awesome"))
  })


}

# mileage_valueBox <- function(input, gear_type) {
#
#   # calculate total mileage (shoes) -----
#   filtered_gear <- reactive({
#
#     # set inputs and icons based on user input
#     if (gear_type == "shoes") {
#
#       gearName_input <- input$gear_shoes_input
#       icon_name <- "shoe-prints"
#
#     } else if (gear_type == "bike") {
#
#       gearName_input <- input$gear_bike_input
#       icon_name <- "bicycle"
#
#     }
#
#     # filter data
#     acts |> filter(gear_name == gearName_input) |>
#       summarize(total = sum(total_miles))
#
#   })
#
#   # render valueBox ----
#   renderInfoBox({
#     valueBox("Total Mileage", value = filtered_gear(), color = "black", icon = icon(icon_name, lib = "font-awesome"))
#   })
#
#
# }
