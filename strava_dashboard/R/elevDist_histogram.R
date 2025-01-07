elevDist_histogram <- function(input, xvar, xlab) {

  # filter by sport_type and select a date range for HISTOGRAMS ----
  filtered_sport_date_histogram <- reactive({

    validate(
      need(length(input$sport_histogram_input) > 0, "Please select at least one activity to visualize data for.")
    )

    # NOT WORKING YET
    validate(
      need(length(input$date_histogram_input) > 0, "There are no recorded activities in the chosen date range. Try a different date range.")
    )

    acts |>
      filter(sport_type %in% input$sport_histogram_input) |>
      filter(start_date_local >= input$date_histogram_input[1] & start_date_local <= input$date_histogram_input[2])

  })

  # render plot ----
  renderPlot({

    ggplot(filtered_sport_date_histogram(), aes(x = {{ xvar }}, fill = sport_type_alt)) +
      geom_histogram(position = "identity", alpha = 0.7) +
      scale_x_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 8)) +
      scale_y_continuous(expand = c(0, 0), breaks = scales::pretty_breaks(n = 5)) +
      labs(x = xlab,
           y = "Count") +
      scale_fill_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      stravaTheme

  })

}
