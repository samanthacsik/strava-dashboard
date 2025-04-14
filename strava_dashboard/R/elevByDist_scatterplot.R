elevByDist_scatterplot <- function(input) {

  # filter by sport_type and select a date range for scatterplot ----
  filtered_sport_date_scatterplot <- reactive({

    validate(
      need(length(input$sport_scatterplot_input) > 0, "Please select at least one activity to visualize data for.")
    )

    # NOT WORKING YET
    validate(
      need(length(input$date_scatterplot_input) > 0, "There are no recorded activities in the chosen date range. Try a different date range.")
    )

    acts |>
      filter(sport_type %in% input$sport_scatterplot_input) |>
      filter(start_date_local >= input$date_scatterplot_input[1] & start_date_local <= input$date_scatterplot_input[2]) %>%
      mutate(marker = paste0("Activity Title: ", name, "<br>",
                             "Date: ", start_date_local, "<br>",
                             "Total Miles: ", total_miles, "<br>",
                             "Total Elevation Gain: ", elevation_gain_ft, "<br>",
                             "Moving Time: ", moving_time_hrs_mins, "<br>",
                             "Total Time: ", elapsed_time_hrs_mins))
  })

  # renderPlotly ----
  renderPlotly({

    elev_dist_scatterplot <- ggplot(filtered_sport_date_scatterplot(),
                                    aes(x = total_miles,
                                        y = elevation_gain_ft,
                                        color = sport_type_alt,
                                        shape = sport_type_alt,
                                        text = marker,
                                        group = total_miles)) +
      geom_point(alpha = 0.8, size = 3) +
      labs(x = "Total Distance Traveled (miles)",
           y = "Total Elevation Gain (feet)") +
      scale_y_continuous(labels = scales::label_number(scale = 0.001, suffix = "k")) +
      scale_color_manual(name = "Sport",
                         values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      scale_shape_manual(name = "Sport",
                         values = c("Hike" = 15, "Bike" = 16, "Walk" = 17)) +
      stravaTheme()

    plotly::ggplotly(elev_dist_scatterplot,
                     tooltip = c("text"))
                     # tooltip = c("total_miles", "elevation_gain_ft"))

  })


}
