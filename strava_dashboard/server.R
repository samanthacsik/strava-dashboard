# ~~~~~~~~~ server ~~~~~~~~~ #

server <- function(input, output) {

  #.....................gear garage valueBoxes.....................
  output$gear_shoes_mileage <-  shoeMileage_valueBox(input)
  output$gear_bike_mileage <- bikeMileage_valueBox(input)

  #....................valueBoxes & leaflet map....................
  output$total_filtered_hikes <- filteredHikes_valueBox(input)
  output$total_filtered_rides <- filteredRides_valueBox(input)
  output$total_filtered_walks <- filteredWalks_valueBox(input)
  output$strava_map <- leaflet_map(input)

  #..................elevation & distance data viz.................
  output$dist_histogram <- elevDist_histogram(input, xvar = total_miles, xlab = "Total Distance (miles)")
  output$elev_histogram <- elevDist_histogram(input, xvar = elevation_gain_ft, xlab = "Total Elevation Gain (ft)")
  output$elev_dist_scatterplot <- elevByDist_scatterplot(input)

  #............elevation & distance summary stats table............
  output$dist_elev_stats_table <- elevDist_sumStats_table(input)

  #......................DT table (raw data).......................
  output$strava_data_trimmed <- stravaData_DTdatatable(input)
  output$strava_map_table <- leaflet_map_table(input)










  ##############################
  # photo slideshow -- COME BACK TO THIS LATER
  ##############################

  # output$caption_ui <- renderUI({
  #   if(input$caption_check) {
  #     textInput("caption", "Caption", value=captions)
  #   }
  # })
  #
  # output$gallery_imgs <- pixture::renderPixfigure({
  #
  #   # path <- "www/slideshow_photos"
  #
  #
  #   if(!is.null(input$path)) path <- unlist(strsplit(input$path, ";"))
  #
  #   if(input$caption_check){
  #     if(!is.null(input$caption)){
  #       cpt <- unlist(strsplit(input$caption, ";"))
  #       if(length(cpt)!=length(path)) stop("Number of captions do not match number of images.")
  #       pixture::pixfigure(path, caption=cpt, h = input$height, w = input$width, fit = input$fit, position = input$position)
  #     }
  #   }else{
  #     pixture::pixfigure(path, h = input$height, w = input$width, fit = input$fit, position = input$position)
  #   }
  # })

  # })

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










