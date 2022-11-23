# server ----

server <- function(input, output) {

##############################
# value boxes
##############################

  # calculate total activities for each sport_type (also used in leaflet map, below) ----
  hikes_only <- acts |> filter(sport_type == "Hike") |> nrow()
  rides_only <- acts |> filter(sport_type == "Ride") |> nrow()
  walks_only <- acts |> filter(sport_type == "Walk") |> nrow()

  # total activity by sport valueBoxes ----
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
# leaflet map
##############################

  # filter for date range ----
  filtered_map <- reactive({
    acts |>
      filter(total_miles >= input$distance_sliderInput[1] & total_miles <= input$distance_sliderInput[2]) |>
      filter(elevation_gain_ft >= input$elevation_sliderInput[1] & elevation_gain_ft <= input$elevation_sliderInput[2])
  }) # END filtered_map

  # filter data by sport_type for mapping icons ----
  hike_data <- reactive({
    filtered_map() |> filter(sport_type == "Hike")
  })

  ride_data <- reactive({
    filtered_map() |> filter(sport_type == "Ride")
  })

  walk_data <- reactive({
    filtered_map() |> filter(sport_type == "Walk")
  })

  ############################## basemap & markers ##############################

  # create heatmap
  output$strava_map <- renderLeaflet({

    # create map ----
    heatmap <- leaflet() |>

      # add tiles
      addProviderTiles("Esri.WorldTerrain",
                       options = providerTileOptions(maxNativeZoom = 19, maxZoom = 100)) |>

      # add miniMap (corner)
      addMiniMap(toggleDisplay = TRUE) |>

      # set view over Santa Barbara
      setView(lng = -119.753042, lat = 34.484782, zoom = 10) |>

      # add clickable hiker markers with info about each hike
      addMarkers(data = hike_data(), icon = hiker_icon_custom,
                 group = "Display Hike Icons",
                 lng = ~jitter(lng, factor = 6), lat = ~jitter(lat, factor = 6),
                 popup = paste("Hike Title:", hike_data()$name, "<br>",
                               "Distance (miles):", hike_data()$total_miles, "<br>",
                               "Elevation gain (ft):", hike_data()$elevation_gain_ft)) |>

      # add clickable bike markers with info about each ride
     addMarkers(data = ride_data(), icon = bike_icon_custom,
                group = "Display Bike Ride Icons",
                lng = ~jitter(lng, factor = 6), lat = ~jitter(lat, factor = 6),
                popup = paste("Ride Title:", ride_data()$name, "<br>",
                              "Distance (miles):", ride_data()$total_miles, "<br>",
                              "Elevation gain (ft):", ride_data()$elevation_gain_ft)) |>

     # add clickable walker markers with info about each  walk
     addMarkers(data = walk_data(), icon = walk_icon_custom,
                group = "Display Walk Icons",
                lng = ~jitter(lng, factor = 6), lat = ~jitter(lat, factor = 6),
                popup = paste("Walk Title:", walk_data()$name, "<br>",
                              "Distance (miles):", walk_data()$total_miles, "<br>",
                              "Elevation gain (ft):", walk_data()$elevation_gain_ft)) |>

     # allow for toggling makers on/off
     addLayersControl(
       overlayGroups = c("Display Hike Icons", "Display Bike Ride Icons", "Display Walk Icons"),
       options = layersControlOptions(collapsed = TRUE)) |>

     # add heatmap legend
     addLegend(colors = c("#b35702", "#744082", "#366643"), # "#DF0101", "#070A8D", "#0F9020"
               labels = c("Hike", "Ride", "Walk"),
               position = "bottomleft")

    ############################## heatmap ##############################

     # get unique activity ids ----
     # unique_acts_ids <- unique(filtered_map()$id)

     # for (i in unique_acts_ids) {
     #
     #   # 1) get activity
     #   activity <- filter(filtered_map(), id == i)
     #
     #   # 2) decode polyline
     #   coords <- googleway::decode_pl(activity$map.summary_polyline)
     #
     #   #3) plot activity trace on basemap; color-code according to activity type
     #   heatmap <- if (activity$sport_type == "Ride") {
     #     addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
     #                  color = "#744082", opacity = 2/4, weight = 2) #070A8D
     #   } else if (activity$sport_type == "Hike") {
     #     addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
     #                  color = "#b35702", opacity = 2/4, weight = 2) #DF0101 #b35702
     #   } else if (activity$sport_type == "Walk") {
     #     addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
     #                  color = "#366643", opacity = 2/4, weight = 2) #0F9020
     #   } # END if else
     #
     # } # END for loop

   }) # END renderLeaflet














  # # filter data by sport_type for mapping icons ----
  # hike_data <- acts |> filter(sport_type == "Hike")
  # ride_data <- acts |> filter(sport_type == "Ride")
  # walk_data <- acts |> filter(sport_type == "Walk")

  # map ----
  # output$strava_map <- renderLeaflet({
  #
  #   heatmap # find code in R/leaflet.R
  #
  # })




























##############################
# elevation & distance data viz
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


##############################
# elevation & distance summary stats table
##############################

  # filter acts and calc summary stats ----
  filtered_stats <- reactive({

    acts |>
      filter(sport_type %in% input$sport_histogram) |>
      filter(start_date_local > input$date_histogram[1] & start_date_local < input$date_histogram[2]) |>
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
  output$dist_elev_stats_table <- renderTable(filtered_stats())
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

  output$strava_data_trimmed <- DT::renderDataTable({
    DT::datatable(acts_trimmed,
                  options = list(pageLength = 5, scrollX = TRUE),
                  rownames = FALSE
                  # caption = htmltools::tags$caption(
                  #   style = 'caption-side: top; text-align: left;',
                  #   'Table 1: ', htmltools::em('Strava data. Only a subset of variables are displayed. Data are updated periodically and may not reflect the most recent activity recordings.')))
    ) # END datatable
  })

}
