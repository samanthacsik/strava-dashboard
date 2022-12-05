Retrieving data first requires a Strava API Application, which you can create from your Strava profile. For me, this was the most confusing part, so I've detailed out my steps on this [README](https://github.com/samanthacsik/strava-dashboard/blob/main/README.md). 

Next, I used the following [`{rStrava}`](https://cran.r-project.org/web/packages/rStrava/index.html) functions to get my data: 

1. create your Strava token using [`strava_oauth()`](https://search.r-project.org/CRAN/refmans/rStrava/html/strava_oauth.html) (you'll need your app name, client ID, secred & scope)

2. pull a list of desired activities using [`get_activity_list()`](https://search.r-project.org/CRAN/refmans/rStrava/html/get_activity_list.html)

3. convert your activity list into a dataframe for easier wrangling using [`compile_activities()`](https://search.r-project.org/CRAN/refmans/rStrava/html/compile_activities.html)

From there, you'll likely need to do a bit of data wrangling (e.g. unit conversions) and cleaning to get things in a plot-friendly format. If interested, check out my cleaning script ([`R/scrape_strava.qmd`](https://github.com/samanthacsik/strava-dashboard/blob/main/R/scrape_strava.qmd)) to see how I approached this.


