# ~~~~~~~~~ user interface (UI) ~~~~~~~~~ #

# ------------------------------------------ header ------------------------------------------
header <- dashboardHeader(

  # add title ----
  title = span(img(src="media/strava_logo.png", width = 38,
                   href = "https://www.strava.com/", target = "_blank"), # target = "_blank" opens link in new tab
               span("Sam's Strava Stats", style = "font-size: 18px;"))
) # END dashboardHeader

# ------------------------------------------ sidebar ------------------------------------------
sidebar <- dashboardSidebar(

  # sidebarMenu ----
  sidebarMenu(

    menuItem("About the app", tabName = "about", icon = icon("star")),
    menuItem("Strava Dashboard", tabName = "dashboard", icon = icon("tachometer-alt")),
    menuItem("Data", tabName = "data", icon = icon("database")),
    menuItem("Photo Gallery", tabName = "photos", icon = icon("camera"))

  ) # END sidebarMenu

) # END dashboardSidebar

# ------------------------------------------ body ------------------------------------------
body <- dashboardBody(

  # header; load stylesheet & fontawesome kit ----
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$script(src = "https://kit.fontawesome.com/b7f4c476ba.js"),
  ), # END header

  # tabItems ----
  tabItems(

    # ---------- about tab ----------
    tabItem(tabName = "about",
            tags$img(class = "banner", src = "media/camuesa_cropped.jpeg",
                     alt = "A landscape photo of a golden field of grass that stretches towards rolling dark green/brown hills. The sun is rising over the hilltops to the left and the sky is clear. A narrow trail weaves down the center. In the foreground, there are a few bent metal posts with barbed wire streteched between them. In front of the fence, there is a crooked metal sign reading 'Camuesa Connector Trail'."),

            # fluidRow with intro & getting data text boxes ----
            fluidRow(

              # intro box ----
              box(width = 6,
                  title = tagList(icon("tachometer-alt"), strong("Why Build a Strava Dashboard?")),
                  includeMarkdown("text/intro.md")
              ), # END intro box

              # scrape data box ----
              box(width = 6,
                  title = tagList(icon("database"), strong("Getting Strava Data")),
                  includeMarkdown("text/getting_data.md")
              ), # END scrape strava box

            ), # END fluidRow

            # fluidRow with update data box ----
            fluidRow(

              box(width = 12,
                  title = tagList(icon("table"), strong("Updating App Data")),
                  includeMarkdown("text/updating_data.md")
              ) # END box

            ), # END fluidRow

            # fluidRow with footer ----
            fluidRow(

              includeMarkdown("text/home_page_footer.md")

            ) # END fluidRow

    ), # END "about" tabItem

    # ---------- dashboard tab ----------
    tabItem(tabName = "dashboard",

            # dashboard tabsetPanel ----
            tabsetPanel(id = "dashboard_tabsetPanel",

                        # map tabPanel ----
                        tabPanel(title = "Gear Tracker & Heat Map",

                                 # style valueBox colors (tried moving this to styles.css but haven't got it working yet)
                                 tags$style(".small-box.bg-orange { background-color: #b35702 !important; color: #FFFFFF !important; }"),
                                 tags$style(".small-box.bg-purple { background-color: #744082 !important; color: #FFFFFF !important; }"),
                                 tags$style(".small-box.bg-green { background-color: #366643 !important; color: #FFFFFF !important; }"),
                                 tags$style(".small-box.bg-black { background-color: #64605f !important; color: #FFFFFF !important; }"),

                                 # first row  (contains gear garage & leaflet boxes)----
                                 fluidRow(

                                   # gear garage box ----
                                   box(width = 4,
                                       title = tagList(icon("warehouse"), strong("Gear Garage")),
                                       includeMarkdown("text/gear_garage.md"),

                                       # creates some extra space ----
                                       headerPanel(""),
                                       headerPanel(""),

                                       # shoes pickerInput & valueBoxOutput ----
                                       shoes_pickerInput(inputId = "gear_shoes_input"),
                                       valueBoxOutput(outputId = "gear_shoes_mileage", width = 12) |> withSpinner(color = "#cb9e72", type = 1),

                                       # bike pickerInput & valueBoxOutput----
                                       bike_pickerInput(inputId = "gear_bike_input"),
                                       valueBoxOutput(outputId = "gear_bike_mileage", width = 12) |> withSpinner(color = "#cb9e72", type = 1),

                                       # photo of boots & caption ----
                                       tags$img(class = "banner", src = "media/danner.jpeg"),
                                       includeMarkdown("text/danner.md")

                                   ), # END gear garage box

                                   # leaflet box ----
                                   box(width = 8,
                                       title = tagList(icon("map-location-dot"), strong("Activity Heat Map")),
                                       includeMarkdown("text/leaflet_info.md"),

                                       # creates some extra space
                                       headerPanel(""),
                                       headerPanel(""),

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

                                 ) # END first fluidRow

                        ), # END map tabPanel

                        # dist & elev tabPanel ----
                        tabPanel(title = "Distance & Elevation Stats",

                                 # dist & elev fluidRow ----
                                 fluidRow(

                                   tabBox(width = 12,
                                          title = tagList(icon("mountain-sun"), strong("Explore distance and elevation stats")),
                                          side = "right", selected = "Distance & Elevation Summary Stats",

                                          # elev by dist scatterplot tabPanel ----
                                          tabPanel("Elevation Gain / Distance Scatterplot",

                                                   sportType_pickerInput(inputId = "sport_scatterplot_input"),
                                                   dateRange_airDatepickerInput(inputId = "date_scatterplot_input"),
                                                   plotly::plotlyOutput(outputId = "elev_dist_scatterplot") |> withSpinner(color = "#cb9e72", type = 1)

                                          ), # END elev by dist scatterplot tabPanel

                                          # dist & elev histograms tabPanel ----
                                          tabPanel("Distance & Elevation Summary Stats",
                                                   sportType_pickerInput(inputId = "sport_histogram_input"),
                                                   dateRange_airDatepickerInput(inputId = "date_histogram_input"),
                                                   splitLayout(cellWidths = c("50%", "50%"),
                                                               plotOutput(outputId = "dist_histogram") |> withSpinner(color = "#cb9e72", type = 1),
                                                               plotOutput(outputId = "elev_histogram") |> withSpinner(color = "#cb9e72", type = 1)),
                                                   headerPanel(""),
                                                   headerPanel(""),
                                                   tableOutput(outputId = "dist_elev_stats_table")
                                          ), # END dist & elev histograms tabPanel

                                   ) # END tabBox

                                 ) # END dist & elev fluidRow

                                 # fluidRow cluster analysis ----
                                 # fluidRow(
                                 #   box(width = 12,
                                 #       title = tags$strong("Kmeans Cluster Analysis"))
                                 # ) # END fluidRow

                        ) # END dist & elev tabPanel

            ) # END dashboard tabsetPanels

    ), # END "dashboard" tab

    # ---------- data tab ----------
    tabItem(tabName = "data",

            # separator box ----
            fluidRow(

              box(width = 12,

                  # caption & table ----
                  includeMarkdown("text/data_info.md"),
                  DT::dataTableOutput(outputId = "strava_data_trimmed") |> withSpinner(color = "#cb9e72", type = 1)

              ) # END box

            ), # END fluidRow

    ), # END "data" tab

    # ---------- photos tab ----------
    tabItem(tabName = "photos",

            h3("Coming soon!")

            # sidebarLayout(
            #   sidebarPanel(width=3,
            #                textAreaInput("path", "Image URLs", value=path, height="200px"),
            #                checkboxInput("caption_check", "Use captions", value=FALSE),
            #                uiOutput("caption_ui"),
            #                textInput("height", label = "Height", value="auto"),
            #                textInput("width", label = "Width", value="100%"),
            #                textInput("fit", label = "Object fit", value="cover"),
            #                textInput("position", label = "Object position", value="center"),
            #                HTML("Image from <a href='https://www.pexels.com/'>Pexels.</a>")
            #   ),
            #   mainPanel(width=9,
            #             pixture::pixfigureOutput("fig")))

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
