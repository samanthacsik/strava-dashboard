put_strava_data <- function(file_name) {
  put_object(
    file = here::here("strava_dashboard", "data", file_name), #file.path("herbarium", "tiny_images", file),
    object = file,
    bucket = "s3://sams-strava-dashboard-data/",
    acl = "private"
  )
}
