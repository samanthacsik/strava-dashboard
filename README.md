# A shiny dashboard for exploring my personal Strava data

## Why build a [Strava](https://www.strava.com/) dashboard?

A few reasons! 

- I started recording my hikes on Strava during the pandemic and quickly became obsessed with my log of activites for looking back on where I've explored. I created a leaflet heat map (find my original `strava-hikes` repo [here](https://github.com/samanthacsik/strava-hikes)) of my activities (check it out on my [personal website](https://samanthacsik.github.io/about.html)!) to include with my first [introduction Tweet](https://twitter.com/WeAreRLadies/status/1533837942782775297) when I curated for [@WeAreRLadies](https://twitter.com/WeAreRLadies) in June 2022 and quickly discovered that I wanted more ways to interact with my data (read: a Shiny app).
- I've been teaching an [Intro to Shiny](https://ucsb-meds.github.io/EDS-430-Intro-to-Shiny/) short course for UCSB's [Master of Environmental Data Science](https://bren.ucsb.edu/masters-programs/master-environmental-data-science/academics-meds) (MEDS) program since 2022, but didn't have a *ton* of personal experiences building Shiny apps or dashboards when I first started. What better way to learn than to embark on a personal project that you're excited about, right?! 
- I want to get into the habit of having a personal project to work on for learning new skills (and to add to my portfolio). Shiny is exciting because there are tons of ways to optimize your code to make your app run more efficiently, lots of complementary packages to enhace features, and endless ways to look at data. While it's a bit hard to find time to iterate consistently on this dashboard, it's a fun project to return to when I'm trying to learn a new Shiny skill for the first time.

**You can explore the current version of the dashboard (which I've affectionately dubbed, Sam's Strava Stats) at <https://samanthacsik.shinyapps.io/strava_dashboard/>.**

## Repository organization

There are lots of files in this repo, some of which are non-functional works-in-progress. Below is a map of the most important (and yes, functioning) files for making this dashboard run.

```
.
├── R/                                # scripts for scraping data & trying out visuals and analyses 
│   └── scrape_strava.qmd             # retrieve and wrangle Strava data  
│   └── leaflet_map.qmd               # build leaflet map (used for saving widget to embed in my personal website)
|   └── media/                        # pngs for leaflet marker icons
|
├── strava_dashboard/                 # app directory 
|   └── R/                            # functions, themes, plots
|   └── data/                         # .rds file (generated in ./R/scrape_strava.qmd) containing cleaned activity data, for reading into app   
|   └── text/                         # markdown files containing text used throughout the app
|   └── www/                          # special directory in shiny for images, stylesheets, etc. 
|      └── media/                     # images & logos used throughout app
|      └── styles.css                 # stylesheet for customzing dashboard
|   └── global.R                      # data, objects, etc. that need to be available across app
|   └── ui.R                          # user interface
|   └── server.R                      # server
|   └── rsconnect/shinyapps.io/samanthacsik # shinyapps.io deployment
|
├── README.md
├── .gitignore        
└── strava_dashboard.Rproj
```

## Retrieving Strava data 

I retrieve my personal Strava data using the [`{rStrava}` package](https://github.com/fawda123/rStrava), which provides some really nice functions for accessing data from Strava's [v3 API](https://developers.strava.com/docs/reference/). This retrieval and data cleaning / wrangling occurs *outside* of my dashboard in `./R/scrape-strava.qmd`. A cleaned version of the data set is then saved as an RDS file to an AWS S3 bucket. The application reads this cleaned data in directly from the S3 bucket.  

If you're interested in grabbing your own Strava data, but aren't sure where to begin, I've detailed my steps in [this wiki](https://github.com/samanthacsik/strava-dashboard/wiki/Creating-a-Strava-API-Application-&-authentication).

## Report a bug

I certainly don't expect the community at large to be doing deep dives into this code base, but if you *happen* to be checking things out and spot something that's not working like it seems it should, feel free to [file an issue](https://github.com/samanthacsik/strava-dashboard/issues) (brief but informative descriptions of the issue and screenshots are helpful!). 

## Contributors

This is a personal project by yours truly, [Samantha Csik](https://github.com/samanthacsik).

## Acknowledgements

I was first inspired to embark on this little personal project when I stumbled upon by [Daniel Cullen](https://www.dancullen.me/home)'s blog post, [Creating a Heatmap in R with Google Polylines](https://www.dancullen.me/articles/creating-a-heatmap-in-r-with-google-polylines). Daniel shares instructions for creating a heatmap using Strava data *just* like I was hoping to do (and ironically, his map features his runs in my current home town of Santa Barbara, CA -- small world!). This blog post is also what introduced me to [Marcus Beck](https://github.com/fawda123)'s [`{rStrava}` package](https://github.com/fawda123/rStrava), a package that provides functions for accessing data from Strava's v3 API. A few other resources that I referenced include: 

-  [Getting Started with the Strava API](https://developers.strava.com/docs/getting-started/)
-  [How to Scrape and Store Strava Data Using R](https://rviews.rstudio.com/2021/11/22/strava-data/), by Julian During
-  [Animate your Strava activities in R using rStrava and gganimate](https://padpadpadpad.github.io/post/animate-your-strava-activities-using-rstrava-and-gganimate/) by Daniel Padfield

Lastly, all of my gratitude and love for these three muskateers -- from left to right: Levi, Molly, & Tallie -- who make exploring the outdoors more fun, always.  

![Levi, Molly, and Tallie](https://github.com/samanthacsik/strava-dashboard/assets/43836046/2f45202d-5a64-4439-8d44-c1cde796465b)

## License

The source code for this dashboard is licensed under the [MIT license](https://github.com/samanthacsik/strava-dashboard/blob/main/LICENSE).

