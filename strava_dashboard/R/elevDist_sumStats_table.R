elevDist_sumStats_table <- function(input) {

  # filter acts and calc summary stats ----
  filtered_stats <- reactive({

    acts |>
      filter(sport_type %in% input$sport_histogram_input) |>
      filter(start_date_local > input$date_histogram_input[1] & start_date_local < input$date_histogram_input[2]) |>
      summarize(
        #`Total # of Activities` = nrow(),
        `Min Distance (mi)` = min(total_miles),
        `Avg Distance (mi)` = mean(total_miles),
        `Max Distance (mi)` = max(total_miles),
        `Aggregate Distance (mi)` = sum(total_miles),
        `Min Elevation Gain (ft)` = min(elevation_gain_ft),
        `Avg Elevation Gain (ft)` = mean(elevation_gain_ft),
        `Max Elevation Gain (ft)` = max(elevation_gain_ft),
        `Aggregate Elevation Gain (ft)` = sum(elevation_gain_ft)
      )

  })

  # render table ----
  renderTable(filtered_stats(), bordered = TRUE)
}
