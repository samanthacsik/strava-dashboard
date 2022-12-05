# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(

  # add title ----
  title = span(img(src="media/strava_logo.png", width = 38,
                   href = "https://www.strava.com/",
                   target = "_blank"), # target = "_blank" opens link in new tab
               span("Sam's Strava Stats", style = "font-size: 18px;"))
  ) # END dashboardHeader

# ------------------------------------------ sidebar ------------------------------------------
sidebar <- dashboardSidebar(

  # START sidebarMenu
  sidebarMenu(

    menuItem("About the app", tabName = "about", icon = icon("star")),
    menuItem("Strava Dashboard", tabName = "dashboard", icon = icon("tachometer-alt")),
    menuItem("Data", tabName = "data", icon = icon("database")),
    menuItem("Photo Gallery", tabName = "photos", icon = icon("camera"))

  ) # END sidebarMenu

) # END dashboardSidebar

# ------------------------------------------ body ------------------------------------------
body <- dashboardBody(

  # import theme (HAVEN'T QUITE FIGURED THIS OUT YET) ----
  # use_theme(my_theme),

  # load stylesheet & fontawesome kit ----
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$script(src = "https://kit.fontawesome.com/b7f4c476ba.js"),
  ), # END tags$head

  # dynamic resizing of danner boots photo (figure out how to move to styles.css) ----
  # tags$head(
  #   tags$style(
  #   type="text/css",
  #   "#danners img {max-width: 100%; width: 100%; height: auto}")
  #   ), # END tags$head

  # dynamic resizing of danner boots photo (figure out how to move to styles.css) ----
  # tags$head(
  #   tags$style(
  #     type="text/css",
  #     "#strava_map img {max-width: 100%; width: 100%; height: auto}")
  # ), # END tags$head

  # tabItems() ----
  tabItems(

    # ---------- about tab ----------
    tabItem(
      tabName = "about",
      tags$img(class = "banner",
               src = "media/camuesa_cropped.jpeg"),
      fluidRow(

        # intro box ----
        box(width = 6,
            title = tags$div(#class = "intro_box_title",
              span(
                tags$i(class="fa-solid fa-tachometer-alt"),
                tags$b("Why Build a Strava Dashboard?")
              ), # EO span
            ), # EO div
          includeMarkdown("text/intro.md")
        ), # END intro box

        # scrape data box ----
        box(width = 6,
            title = tags$div(#class = "intro_box_title",
                       span(
                         tags$i(class="fa-solid fa-database"),
                         tags$b("Getting Strava Data")
                       ), # EO span
              ), # EO div
            includeMarkdown("text/getting_data.md")
            ), # END scrape strava box
      ), # END fluidRow,

      # update data box ----
      fluidRow(
        box(width = 12,
            title = tags$div(#class = "intro_box_title",
              span(
                tags$i(class="fa-solid fa-table"),
                tags$b("Updating App Data")
              ), # EO span
            ), # EO div
            includeMarkdown("text/updating_data.md")
            ) # END box
      ), # END fluidRow

      # footer ----
      fluidRow(
        includeMarkdown("text/home_page_footer.md")
      ) # END fluidRow

    ), # END "about" tabItem

    # ---------- dashboard tab ----------
    tabItem(
      tabName = "dashboard",

      # style valueBox colors (tried moving this to styles.css but haven't got it working yet)
      tags$style(".small-box.bg-orange { background-color: #b35702 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-purple { background-color: #744082 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-green { background-color: #366643 !important; color: #FFFFFF !important; }"),
      tags$style(".small-box.bg-black { background-color: #64605f !important; color: #FFFFFF !important; }"),


      # style box header colors
      # tags$style(".box.box-solid.box-primary>.box-header {background-color: #98A08D!important; } color: #FFFFFF !important; }"),

      # first row  (contains gear garage & leaflet boxes)----
      fluidRow(

        # gear garage box ----
        box(width = 4, # height = 930, (setting height causes problems with dynamic screen size)
            span(
              tags$div(includeMarkdown("text/gear_garage.md"))
            ), # END span

            # gear_shoes pickerInput ----
            pickerInput(inputId = "gear_shoes", label = "Select shoes:",
                        choices = c("Danner Jag #3" = "danner3", "Danner Jag #2" = "danner2", "Danner Jag #1" = "danner1",
                                    "Lowa Renegade" = "lowa", "Reebok Nano (black/white)" = "nano"),
                        selected = "Danner Jag #3",
                        multiple = FALSE), # END gear pickerInput

            # shoes mileage infoBoxOutput ----
            valueBoxOutput(outputId = "gear_shoes_mileage", width = 12) |> withSpinner(color = "#cb9e72", type = 1),

            # gear_bike pickerInput ----
            pickerInput(inputId = "gear_bike", label = "Select bike:",
                        choices = c("Canyon Grail 7 (gravel)" = "grail", "Tandemania (tandem road bike)" = "tandem", "Yeti (MTB)" = "yeti",
                                    "Trek (MTB)" = "trek", "Cannondale (MTB)" = "cannondale"),
                        selected = "Canyon Grail 7 (gravel)",
                        multiple = FALSE), # END gear pickerInput


            # bike mileage infoBoxOutput ----
            valueBoxOutput(outputId = "gear_bike_mileage", width = 12) |> withSpinner(color = "#cb9e72", type = 1),

            # photo of boots ----
            # tags$img(src = "media/danner.jpeg",
            #   align = "center",
            #   style = "width: 100%; height: 15em; display: block; margin-left: auto; margin-right: auto;",
            # ) # end tags$img (danner.jpeg)

            tags$img(class = "banner",
                     src = "media/danner.jpeg"),
            # imageOutput(outputId = "danners"),

            # danner description ----
            span(
              tags$div(includeMarkdown("text/danner.md"))
            )
          ), # END gear garage box

        # leaflet box ----
        box(width = 8, # height = 930,

            # leaflet box header text ----
            span(
              tags$div(includeMarkdown("text/leaflet_info.md"))
            ), # END span

            # value boxes, sliderInputs, leaflet map ----
            valueBoxOutput(outputId = "total_filtered_hikes"),
            valueBoxOutput(outputId = "total_filtered_rides"),
            valueBoxOutput(outputId = "total_filtered_walks"),
            sliderInput(inputId = "distance_sliderInput", label = "Select a distance (miles) range:",
                        min = min(acts$total_miles), max = max(acts$total_miles),
                        value = c(min(acts$total_miles), max(acts$total_miles))),
            sliderInput(inputId = "elevation_sliderInput", label = "Select a range of elevation gain (ft):",
                        min = min(acts$elevation_gain_ft), max = max(acts$elevation_gain_ft),
                        value = c(min(acts$elevation_gain_ft), max(acts$elevation_gain_ft))),
            leafletOutput(outputId = "strava_map") |> withSpinner(color = "#cb9e72", type = 1)
            ) # END leaflet box
      ), # END first fluidRow

      # add some space between map and plots ----
      headerPanel(""),

      # second fluid row (contains distance & elevation plots) ----
      fluidRow(
        tabBox(width = 12,
               title = tags$strong("Explore distance and elevation stats"),
               side = "right", selected = "Distance & Elevation Summary Stats",

               # elev ~ dist scatterplot ----
               tabPanel("Elevation Gained ~ Distance Traveled",
                        sport_type_pickerInput(inputId = "sport_scatterplot"), # sport type input
                        date_range_airDatepickerInput(inputId = "date_scatterplot"), # date range input
                        plotly::plotlyOutput(outputId = "elev_dist_scatterplot") |> withSpinner(color = "#cb9e72", type = 1) # elev ~ dist scatterplot output
               ), # END tabPanel (scatterplot)

               # dist & elev histograms ----
               tabPanel("Distance & Elevation Summary Stats",
                        sport_type_pickerInput(inputId = "sport_histogram"), # sport type input
                        date_range_airDatepickerInput(inputId = "date_histogram"), # date range input
                        splitLayout(cellWidths = c("50%", "50%"), # histogram outputs
                                    plotOutput(outputId = "dist_histogram") |> withSpinner(color = "#cb9e72", type = 1),
                                    plotOutput(outputId = "elev_histogram") |> withSpinner(color = "#cb9e72", type = 1)),
                        tableOutput(outputId = "dist_elev_stats_table")
               ), # END tabPanel (histograms)

              ) # END tabBox
      ), # END second fluidRow
    ), # END "dashboard" tab

    # ---------- data tab ----------
    tabItem(
      tabName = "data",

      # separator box ----
      fluidRow(
        box(width = 12,
            span(
              tags$div(includeMarkdown("text/data_info.md"))
            ), # END span

            # dataTableOutput ----
            DT::dataTableOutput(outputId = "strava_data_trimmed") |> withSpinner(color = "#cb9e72", type = 1)


        ) # END box
      ), # END fluidRow

    ), # END "data" tab

  # ---------- photos tab ----------
    tabItem(
      tabName = "photos",

      # box ----
      # box(width = 12,

          # # actionButton input ----
          # actionButton(inputId = "previous", label = "Previous"),
          # actionButton(inputId = "next", label = "Next")
          #
          # # image output ----
          # imageOutput(outputId = "image")

          # slickROutput(outputId = "slick_output", width = "100%", height = "200px")
          # ), # END box

    ) # END "photos" tab

  ) # END tabItems

) # END dashboardBody

# ------------------------------------------ combine ------------------------------------------
ui <- dashboardPage(title = "Sam's Strava Stats", header, sidebar, body) # title here updates how title appears in browser tab (need to define here bc title in dashboardHeader has media embedded)
