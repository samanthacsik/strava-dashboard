library(rStrava)
library(aws.s3)

source("R/keys-from-env.R")


refresh_strava_token <- function(refresh_token) {
  res <- httr::POST(
    url = "https://www.strava.com/oauth/token",
    body = list(
      client_id = app_client_id,
      client_secret = app_secret,
      grant_type = "refresh_token",
      refresh_token = refresh_token
    )
  )

  new_token <- httr::content(res)
  return(new_token)
}

retrieve_strava_token <- function() {
  # Download prior refresh token from s3 file
  strava_refresh_token <- rawToChar(get_object(refresh_token_filename, bucket=strava_s3_bucket))
  print(substr(strava_refresh_token, 1, 5))
  if (substr(strava_refresh_token, 1, 5) == "<?xml") {
    print(strava_refresh_token)
    return(NULL)
  }
  # create a strava oauth app
  strava_app <- httr::oauth_app("strava", key = app_client_id, secret = app_secret)

  # create strava endpoints
  strava_end <-httr::oauth_endpoint(
    request = "https://www.strava.com/oauth/authorize?",
    authorize = "https://www.strava.com/oauth/authorize",
    access = "https://www.strava.com/oauth/token")

  # refresh the access token with the refresh token from s3
  new_token <- refresh_strava_token(strava_refresh_token)

  if (is.null(new_token)) {
    print("No Token Provided from refresh!")
    return(NULL)
  }
  print(ls(new_token))
  if (is.null(new_token$refresh_token)) {
    print("No Refresh Token found in response!")
    return(NULL)
  }


  # store the newly returned refresh token from strava to s3
  put_object(file = charToRaw(new_token$refresh_token), object=refresh_token_filename, bucket=strava_s3_bucket)

  # save all this info to a oauth2.0 token
  token <- httr::oauth2.0_token(
    endpoint = strava_end,
    app = strava_app,
    credentials = new_token,
    scope = "activity:read_all",
    cache = TRUE
  )
  # Create a token object
  httr::config(token = token)
}
