# A shiny dashboard for exploring my personal Strava data

## Why build a [Strava](https://www.strava.com/) dashboard?

A few reasons! 

- I started recording my hikes on Strava during the pandemic and quickly became obsessed with my log of activites -- both to look back on where I've been and what I've done, and also for chasing those top 10s (I hate to admit it, but it's true...). I created a leaflet heat map (find my original `strava-hikes` repo [here](https://github.com/samanthacsik/strava-hikes)) of my activities (check it out on my [personal website](https://samanthacsik.github.io/about.html)!) to include with my first [introduction Tweet](https://twitter.com/WeAreRLadies/status/1533837942782775297) when I curated for [@WeAreRLadies](https://twitter.com/WeAreRLadies) in June 2022 and quickly discovered that I wanted more ways to interact with my data.
- Despite the fact that I teach an Intro to Shiny workshop to UCSB's Master of Environmental Data Science (MEDS) students, I don't have a *ton* of personal experiences building Shiny apps or dashboards. What better way to learn than to embark on a personal project that you're excited about, right?! 
- I want to get into the habit of having a personal project to work on for learning new skills (and to add to my portfolio). Shiny is exciting because there are tons of ways to optimize your code to make your app run more efficiently, lots of complementary packages to enhace features, and endless ways to look at data.

**You can explore the current version of the dashboard (which I've affectionately dubbed, Sam's Strava Stats) at <https://samanthacsik.shinyapps.io/strava_dashboard/>.**

## Repository organization

There are lots of files in this repo, some of which are non-functional works-in-progress. Below is a map of the most important (and yes, functioning) files for making this dashboard run.

```
.
├── R/                                # scripts for trying out visuals and analyses before adding to the app
│   └── scrape_strava.R                 # retrieve and wrangle Strava data  
│   └── leaflet_map.qmd                 # build leaflet map (used for saving widget to embed in my personal website)
|   └── /media                          # pngs for leaflet marker icons
|
├── strava_dashboard/                 # app directory 
|   └── R                              # functions, themes, plots
|   └── data/                          # .rds files (generated in ./R/scrape_strava.R) for reading into app   
|   └── text/                          # markdown files containing text to be used throughout the app
|      └── danner.md                    # caption for danner boots photo in gear garage
|      └── data_info.md                 # title and caption for DT dataTable
|      └── gear_garage.md               # gear garage box title and description
|      └── home_page_footer.md          # landing page footer 
|      └── intro.md                     # landing page intro text
|      └── leaflet_info.md              # leaflet box title and description
|      └── updating_data.md             # note about app updates   
|   └── www/                           # special directory in shiny for images, stylesheets, etc. 
|      └── media/                       # images & logos used throughout app
|      └── styles.css                   # stylesheet for customzing dashboard
|   └── global.R                            # data, objects, etc. that need to be available across app
|   └── ui.R                                # user interface
|   └── server.R                            # server
|   └── rsconnect/shinyapps.io/samanthacsik # shinyapps.io deployment
|
├── README.md
├── .gitignore        
└── strava_dashboard.Rproj
```

## Excited about retrieving your own Strava data, but don't know where to begin?

I've detailed my steps in [this wiki]()! 

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

You're now ready to retrieve, wrangle, and plot your data! Check out my [`scrape_strava.qmd`](https://github.com/samanthacsik/strava-dashboard/blob/main/R/scrape_strava.qmd) file to see how I retrieved and wrangled my data in preparation for plotting and analysis.

## Acknowledgements

I was first inspired to embark on this little personal project when I stumbled upon by [Daniel Cullen](https://www.dancullen.me/home)'s blog post, [Creating a Heatmap in R with Google Polylines](https://www.dancullen.me/articles/creating-a-heatmap-in-r-with-google-polylines). Daniel shareed instructions for creating a heatmap using Strava data *just* like I was hoping to do (and ironically, his map features his runs in my current home town of Santa Barbara, CA -- small world!). This blog post is also what introduced me to [Marcus Beck](https://github.com/fawda123)'s [`{rStrava}` package](https://github.com/fawda123/rStrava), a package that provides functions for accessing data from Strava's v3 API. A few other resources that I referenced include: 

-  [Getting Started with the Strava API](https://developers.strava.com/docs/getting-started/)
-  [How to Scrape and Store Strava Data Using R](https://rviews.rstudio.com/2021/11/22/strava-data/), by Julian During
-  [Animate your Strava activities in R using rStrava and gganimate](https://padpadpadpad.github.io/post/animate-your-strava-activities-using-rstrava-and-gganimate/) by Daniel Padfield

## Report a bug

I certainly don't expect the community at large to be doing deep dives into this code base, but if you *happen* to be checking things out and spot something that's not working like it seems it should, feel free to [file an issue](https://github.com/samanthacsik/strava-dashboard/issues) (brief but informative descriptions of the issue and screenshots are helpful!). 

## Contributors

This is a personal project by yours truly, [Samantha Csik](https://github.com/samanthacsik).

## License

The source code for this dashboard is licensed under the MIT license, which you can find in the LICENSE.txt file.
