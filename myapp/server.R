# server ----

server <- function(input, output) {

  # valueBoxes ------------
  # filter for total activities by sport-type (for valueBoxes) ----
  hikes_only <- acts |>
    filter(sport_type == "Hike") |>
    nrow()

  rides_only <- acts |>
    filter(sport_type == "Ride") |>
    nrow()

  walks_only <- acts |>
    filter(sport_type == "Walk") |>
    nrow()

  # totalHikes valueBox ----
  output$totalHikes <- renderValueBox({

    valueBox("Total Number of Recorded Hikes",
             value = hikes_only,
             icon = icon("mountain", lib = "font-awesome"),
             color = "light-blue")

  }) # END totalHkes valueBox

  # totalRides valueBox ----
  output$totalRides <- renderValueBox({

    valueBox("Total Number of Recorded Bike Rides",
             value = rides_only,
             icon = icon("bicycle", lib = "font-awesome"),
             color = "olive")

  }) # END totalRides valueBox

  # totalWalks valueBox ----
  output$totalWalks <- renderValueBox({

    valueBox("Total Number of Recorded Walks",
             value = walks_only,
             icon = icon("user", lib = "font-awesome"),
             color = "green")

  }) # END totalRides valueBox

  # filter by sport_type ----
  sport <- reactive({
    acts |>
      filter(sport_type %in% input$sport)
  })

  # render elev_dist_scatterplot ----
  output$elev_dist_scatterplot <- renderPlot({

    ggplot(sport(), aes(x = total_miles, y = elevation_gain_ft, color = sport_type_alt, shape = sport_type_alt)) +
      geom_point(alpha = 0.8, size = 3) +
      labs(x = "Total Distance Traveled (miles)",
           y = "Total Elevation Gain (feet)") +
      scale_color_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      scale_shape_manual(name = "Sport", values = c("Hike" = 15, "Bike" = 16, "Walk" =17)) +
      theme_light() +
      theme(text = element_text(family = "Avenir"), # chosen from Font Book app on my Mac
            axis.text = element_text(color = "black", size = 12),
            axis.title = element_text(size = 13),
            panel.border = element_rect(colour = "black", fill = NA, size = 0.7),
            plot.caption = element_text(size = 10, hjust = 0))

  })

}
