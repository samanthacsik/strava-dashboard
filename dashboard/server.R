# server ----

server <- function(input, output) {

  ##############################
  # breathing room - value boxes
  ##############################

  # valueBoxes ----
  # calculate total activities for each sport_type
  hikes_only <- acts |>
    filter(sport_type == "Hike") |>
    nrow()

  rides_only <- acts |>
    filter(sport_type == "Ride") |>
    nrow()

  walks_only <- acts |>
    filter(sport_type == "Walk") |>
    nrow()

  # total activity by sport valueBoxes
  output$totalHikes <- renderValueBox({
    valueBox("Total Number of Recorded Hikes", value = hikes_only, color = "orange", icon = icon("mountain", lib = "font-awesome"))
  })
  output$totalRides <- renderValueBox({
    valueBox("Total Number of Recorded Rides", value = rides_only, color = "purple", icon = icon("bicycle", lib = "font-awesome"))
  })
  output$totalWalks <- renderValueBox({
    valueBox("Total Number of Recorded Walks", value = walks_only, color = "green", icon = icon("user", lib = "font-awesome"))
  })


##############################
# breathing room - elevation & distance data viz
##############################


  # filter by sport_type and select a date range for SCATTERPLOT ----
  filtered_sport_date_scatterplot <- reactive({

    validate(
    need(length(input$date_scatterplot) > 0, "Please select a date range to visualize activities for.")
    )

    acts |>
      filter(sport_type %in% input$sport_scatterplot) |>
      filter(start_date_local > input$date_scatterplot[1] & start_date_local < input$date_scatterplot[2])
  })

  # render elev_dist_scatterplot ----
  output$elev_dist_scatterplot <- renderPlot({

    ggplot(filtered_sport_date_scatterplot(), aes(x = total_miles, y = elevation_gain_ft, color = sport_type_alt, shape = sport_type_alt)) +
      geom_point(alpha = 0.8, size = 3) +
      labs(x = "Total Distance Traveled (miles)",
           y = "Total Elevation Gain (feet)") +
      scale_color_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      scale_shape_manual(name = "Sport", values = c("Hike" = 15, "Bike" = 16, "Walk" = 17)) +
      stravaTheme

  })

  # filter by sport_type and select a date range for HISTOGRAMS ----
  filtered_sport_date_histogram <- reactive({

    validate(
      need(length(input$date_histogram) > 0, "Please select a date range to visualize activities for.")
    )

    acts |>
      filter(sport_type %in% input$sport_histogram) |>
      filter(start_date_local > input$date_histogram[1] & start_date_local < input$date_histogram[2])
  })

  # render dist_histogram ----
  output$dist_histogram <- renderPlot({
    ggplot(filtered_sport_date_histogram(), aes(x = total_miles, fill = sport_type_alt)) +
      geom_histogram() +
      scale_x_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 8)) +
      scale_y_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 5)) +
      labs(x = "Total Distance (miles)",
           y = "Count") +
      scale_fill_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      stravaTheme
  })

  # render elev_histogram ----
  output$elev_histogram <- renderPlot({
    ggplot(filtered_sport_date_histogram(), aes(x = elevation_gain_ft, fill = sport_type_alt)) +
      geom_histogram() +
      scale_x_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 8)) +
      scale_y_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 5)) +
      labs(x = "Total Elevation Gain (ft)",
           y = "Count") +
      scale_fill_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      stravaTheme
  })

}
