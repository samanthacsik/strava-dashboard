# server ----

server <- function(input, output) {

##############################
# Gear Garage valueBoxes
##############################

  output$gear_shoes_mileage <- shoeMileage_valueBox(input)
  output$gear_bike_mileage <- bikeMileage_valueBox(input)

##############################
# valueBoxes & leaflet map
##############################

  output$total_filtered_hikes <- filteredHikes_valueBox(input)
  output$total_filtered_rides <- filteredRides_valueBox(input)
  output$total_filtered_walks <- filteredWalks_valueBox(input)
  output$strava_map <- leaflet_map(input)

##############################
# elevation & distance data viz
##############################

  # filter by sport_type and select a date range for SCATTERPLOT ----
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
      filter(start_date_local > input$date_scatterplot_input[1] & start_date_local < input$date_scatterplot_input[2])
  })

  # render elev_dist_scatterplot ----
  output$elev_dist_scatterplot <- renderPlotly({

    elev_dist_scatterplot <- ggplot(filtered_sport_date_scatterplot(), aes(x = total_miles, y = elevation_gain_ft, color = sport_type_alt, shape = sport_type_alt)) +
      geom_point(alpha = 0.8, size = 3) +
      labs(x = "Total Distance Traveled (miles)",
           y = "Total Elevation Gain (feet)") +
      scale_color_manual(name = "Sport", values = c("Hike" = "#b35702", "Bike" = "#744082", "Walk" = "#366643")) +
      scale_shape_manual(name = "Sport", values = c("Hike" = 15, "Bike" = 16, "Walk" = 17)) +
      stravaTheme

    plotly::ggplotly(elev_dist_scatterplot,
                     tooltip = c("total_miles", "elevation_gain_ft"))

  })

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
      filter(start_date_local > input$date_histogram_input[1] & start_date_local < input$date_histogram_input[2])
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


##############################
# elevation & distance summary stats table
##############################

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

  # render dist_elev_stats_table ----
  output$dist_elev_stats_table <- renderTable(filtered_stats(),
                                              bordered = TRUE)
  # DT::renderDataTable({
  #   DT::datatable(filtered_stats(),
  #                 rownames = FALSE,
  #                 initComplete = JS(
  #                   "function(settings, json) {",
  #                   "$(this.api().table().header()).css({'background-color': '##98A08D', 'color': '#FFFFFF'});",
  #                   "}"))
  # })


##############################
# DT table ("raw" data)
##############################

  output$strava_data_trimmed <- stravaData_DTdatatable(input)

  ##############################
  # photo slideshow
  ##############################

  # # set initial value ----
  # index <- reactiveVal(value = 1)
  #
  # # event handler ----
  # observeEvent(input[["previous"]], {
  #   index(max(index()-1, 1))
  # })
  # observeEvent(input[["next"]], {
  #   index(min(index()+1, length(imgs)))
  # })
  #
  # # render image ----
  # output$image <- renderImage({
  #   x <- imgs[index()]
  #   list(src = x)
  # }, deleteFile = FALSE)

  # # slickR option not working ----
  # output$slick_output <- slickR::renderSlickR({
  #   slickR::slickR(imgs)
  # })

  ##############################
  # END SERVER
  ##############################

} # END SERVER










