leaflet_map <- function(input) {

  # make icons ----
  hiker_icon_custom <- makeIcon(
    iconUrl = "www/media/hiker.png",
    iconWidth = 20, iconHeight = 20
  )

  bike_icon_custom <- makeIcon(
    iconUrl = "www/media/bike.png",
    iconWidth = 22, iconHeight = 25
  )

  walk_icon_custom <- makeIcon(
    iconUrl = "www/media/walker.png",
    iconWidth = 13, iconHeight = 18
  )

  # filter for distance and elevation ranges based on sliderInputs ----
  filtered_map <- mapFilters(input)

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

  # renderLeaflet ----
  renderLeaflet({

    # initiate map
    heatmap <- leaflet() |>

      # add tiles
      addProviderTiles(providers$Esri.WorldTerrain, group = "ESRI Terrain",
                       options = providerTileOptions(maxZoom = 100)) |>
      # addProviderTiles("Esri.WorldTerrain",
      #                  options = providerTileOptions(maxNativeZoom = 19, maxZoom = 100)) |>

      # add miniMap (corner)
      addMiniMap(toggleDisplay = TRUE) |>

      # set view over Santa Barbara
      setView(lng = -119.753042, lat = 34.484782, zoom = 10) |>

      # add clickable hiker markers with info about each hike
      addMarkers(data = hike_data(), icon = hiker_icon_custom,
                 group = "Display Hike Icons",
                 lng = ~jitter(lng, factor = 0.01), lat = ~jitter(lat, factor = 0.01),
                 popup = paste("Hike Title:", hike_data()$name, "<br>",
                               "Distance (miles):", hike_data()$total_miles, "<br>",
                               "Elevation gain (ft):", hike_data()$elevation_gain_ft)) |>

      # add clickable bike markers with info about each ride
      addMarkers(data = ride_data(), icon = bike_icon_custom,
                 group = "Display Bike Ride Icons",
                 lng = ~jitter(lng, factor = 0.01), lat = ~jitter(lat, factor = 0.01),
                 popup = paste("Ride Title:", ride_data()$name, "<br>",
                               "Distance (miles):", ride_data()$total_miles, "<br>",
                               "Elevation gain (ft):", ride_data()$elevation_gain_ft)) |>

      # add clickable walker markers with info about each  walk
      addMarkers(data = walk_data(), icon = walk_icon_custom,
                 group = "Display Walk Icons",
                 lng = ~jitter(lng, factor = 0.01), lat = ~jitter(lat, factor = 0.01),
                 popup = paste("Walk Title:", walk_data()$name, "<br>",
                               "Distance (miles):", walk_data()$total_miles, "<br>",
                               "Elevation gain (ft):", walk_data()$elevation_gain_ft)) |>

      # allow for toggling makers on/off
      addLayersControl(
        overlayGroups = c("Display Hike Icons", "Display Bike Ride Icons", "Display Walk Icons"),
        options = layersControlOptions(collapsed = TRUE)) |>

      hideGroup(c("Display Hike Icons", "Display Bike Ride Icons", "Display Walk Icons")) |>

      # add heatmap legend
      addLegend(colors = c("#b35702", "#744082", "#366643"), # "#DF0101", "#070A8D", "#0F9020"
                labels = c("Hike", "Ride", "Walk"),
                position = "bottomleft") %>%

      # add reset map button
      leaflet.extras::addResetMapButton()


    # get unique activity ids ----
    unique_acts_ids <- unique(filtered_map()$id)

    # add heatmap traces ----
    for (i in unique_acts_ids) {

      # 1) get activity
      activity <- filter(filtered_map(), id == i)

      # 2) decode polyline
      coords <- googleway::decode_pl(activity$map.summary_polyline)

      # 3) plot activity trace on basemap; color-code according to activity type
      if (activity$sport_type == "Ride") {
        heatmap <- addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
                                color = "#744082", opacity = 2/4, weight = 2) #070A8D
      } else if (activity$sport_type == "Hike") {
        heatmap <- addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
                                color = "#b35702", opacity = 2/4, weight = 2) #DF0101 #b35702
      } else if (activity$sport_type == "Walk") {
        heatmap <- addPolylines(heatmap, lng = coords$lon, lat = coords$lat,
                                color = "#366643", opacity = 2/4, weight = 2) #0F9020
      } # END if else

    } # END for loop

    # return heatmap  ----
    return(heatmap)

  }) # END renderLeaflet

}
