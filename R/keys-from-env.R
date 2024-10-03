app_name <- "SamHeatmaps"
app_client_id <- Sys.getenv("STRAVA_KEY")
app_secret <- Sys.getenv("STRAVA_SECRET")
strava_secret_token <- Sys.getenv("STRAVA_ACCESS_TOKEN")
strava_s3_bucket <- "sams-strava-dashboard-data"
refresh_token_filename <- "strava_refresh_token.txt"
