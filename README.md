# [Sam's Strava Stats](https://samanthacsik.shinyapps.io/strava_dashboard/) - a shiny dashboard for exploring my Strava data

## Why build a [Strava](https://www.strava.com/) dashboard?

A few reasons! 

- I started recording my hikes on Strava during the pandemic and quickly became obsessed with my log of activites -- both to look back on where I've been and what I've done, and also for chasing those top 10s (I hate to admit it, but it's true...). I created a leaflet heat map (find my original `strava-hikes` repo [here](https://github.com/samanthacsik/strava-hikes)) of my activities (check it out on my [personal website](https://samanthacsik.github.io/about.html)!) to include with my first [introduction Tweet](https://twitter.com/WeAreRLadies/status/1533837942782775297) when I curated for [@WeAreRLadies](https://twitter.com/WeAreRLadies) in June 2022 and quickly discovered that I wanted more ways to interact with my data.
- Despite the fact that I teach an Intro to Shiny workshop to UCSB's Master of Environmental Data Science (MEDS) students, I don't have a *ton* of personal experiences building Shiny apps or dashboards. What better way to learn than to embark on a personal project that you're excited about, right?! 
- I want to get into the habit of having a personal project to work on for learning new skills (and to add to my portfolio). Shiny is exciting because there are tons of ways to optimize your code to make your app run more efficiently, lots of complementary packages to enhace features, and endless ways to look at data.

## What's in this repo?

```
.
├── R/                                # scripts for trying out visuals and analyses before adding to the app
│   └── scrape_strava.R                 # retrieve and wrangle Strava data  
│   └── leaflet_map.R                   # build leaflet map (can also save widget for embedding in personal website here)
│   └── test_viz.R                      # trying out random visualizations and analyses
│   └── elevation_profiles.R            # an attempt to parse elevation data from Google polylines, cut short bc the Google API requries a billing account
|   └── /media                          # pngs for leaflet marker icons
|
├── strava_dashboard/                 # folder containing the shiny dashboard 
|   └── R                              # functions, themes, plots
|      └── sport_type_pickerInput.R     # sport type pickerInput function
|      └── date_range_inputs.R          # date range input functions
|      └── fresh_theme.R                # shinydashboard theme created using `{fresh}` (NOT WORKING YET)
|      └── leaflet.R                    # leaflet map for embedding in dashboard (NOT WORKING YET)
|   
|   └── data/                          # rds files for reading into app
|        
|   └── text/                          # markdown files containing text to be used throughout the app
|      └── danner.md                    # caption for danner boots photo in gear garage
|      └── data_info.md                 # title and caption for DT dataTable
|      └── gear_garage.md               # gear garage box title and description
|      └── home_page_footer.md          # landing page footer 
|      └── intro.md                     # landing page intro text
|      └── leaflet_info.md              # leaflet box title and description
|       
|   └── www/                           # special directory in shiny for images, stylesheets, etc. 
|      └── media/                       # photos & logos used throughout app
|      └── slideshow_photos/            # photos to be used in the 'Photos' tab (NOT WORKING YET)
|      └── styles.css                   # stylesheet for customzing dashboard
|      └── strava_theme.css             # created when `fresh_theme.R` is run (NOT WORKING/USED YET)
|
|   └── global.R                       # data, objects, etc. that need to be available across multiple components of app
|   └── ui.R                           # user interface
|   └── server.R                       # server
|   └── rsconnect/shinyapps.io/samanthacsik
|
├── README.md
├── .gitignore        
├── .DS_store
└── strava_dashboard.Rproj
```

## Retrieving my Strava data

If you're looking to work with your own Strava data, the most challenging part (in my experience) was just getting my account set up correctly. You should start by checking out the [Strava API documentation](https://developers.strava.com/docs/getting-started/). If you need a concrete example, here are the exact steps I followed:

1.  Log into Strava (or create an account if you don't already have one)
2.  Click on your profile icon (top right corner) \> Settings \> My API Application (from the left-hand menu)
3.  Provide Strava some information about your app (NOTE: I don't *totally* know what I'm doing here, but the information below worked for me):
    1.  Give your application a name (this can be anything, but I called mine `SamsHeatmaps`)

    2.  Select a category (since I wanted to create a heatmap, I chose `Visualizer` from the dropdown menu)

    3.  Provide a website URL for your app (I included the link to this GitHub repo)

    4.  Give it an Application Description (my description is, `Learning to use the rStrava package and hopefully create my own heatmaps`)

    5.  Provide an Authorized Callback Domain (I wrote `localhost`)

Once you save your API Application information, you'll be provided with both a `Client Secret` and an `Access Token`, both of which you need in order to scrape your data. Using the `rStrava` package makes it pretty easy to do so. The first step is to create a "Strava Token", using the following code:

```{r, eval = FALSE}
app_name <- "<APP NAME>"
app_client_id <- "<CLIENT ID>"
app_secret <- "<CLIENT SECRET>"

my_token <- httr::config(token = strava_oauth(app_name, app_client_id, app_secret,
                                              app_scope = "activity:read_all"))
```

A browser window should open asking you to authorize Strava to access your data. Once you agree, it'll return a message in the browser, `Authentication complete. Please close this page and return to R.` This means things are working!

You're now ready to retrieve, wrangle, and plot your data! Check out my [`scrape_strava.qmd`](https://github.com/samanthacsik/strava-dashboard/blob/main/R/scrape_strava.qmd) file to see how I created my retrieved and wrangled my data in preparation for plotting and analysis.

**Other resources:**

-   [How to Scrape and Store Strava Data Using R](https://rviews.rstudio.com/2021/11/22/strava-data/), by Julian During
-   [Animate your Strava activities in R using rStrava and gganimate](https://padpadpadpad.github.io/post/animate-your-strava-activities-using-rstrava-and-gganimate/) by Daniel Padfield
-   [Creating a Heatmap in R with Google Polylines](https://www.dancullen.me/articles/creating-a-heatmap-in-r-with-google-polylines), by Daniel Cullen
-   [Getting Started with the Strava API](https://developers.strava.com/docs/getting-started/)

